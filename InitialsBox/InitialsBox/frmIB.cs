using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Data.SqlClient;

namespace InitialsBox
{
    public partial class frmIB : Form
    {
        public frmIB()
        {
            InitializeComponent();
            //load the combo box
            loadUserCombo();
        }

        private void loadUserCombo()
        {

            SqlConnection con = new SqlConnection("server=tkcbt;uid=intranet;pwd=popzombie;database=Viewpoint");
            SqlDataAdapter da = new SqlDataAdapter("SELECT a.UserID, a.Name FROM [Intranet].[dbo].[KTUser] a Inner Join Viewpoint.dbo.PREH b on a.Employee = b.Employee and b.ActiveYN = 'Y' order by 2", con);
                        
            con.Open();
            //SqlDataReader dr = cmd.ExecuteReader();
            DataSet ds = new DataSet();
            da.Fill(ds,"Users");

            cbUser.ValueMember = "UserID";
            cbUser.DisplayMember = "Name";
            cbUser.DataSource = ds.Tables["Users"];
                
                
            

            ds.Dispose();    
            da.Dispose();
            con.Close();

            
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            try
            {                
                OpenFileDialog fbd = new OpenFileDialog();
                DialogResult result = fbd.ShowDialog();
                
                txtInitials.Text = fbd.FileName;
            }
            catch { }
        }

        private void btnUpload_Click(object sender, EventArgs e)
        {
            DataRowView drv = cbUser.SelectedItem as DataRowView;
             //lblError.Text = drv.Row["UserID"].ToString();            
            UploadToServer(drv.Row["UserID"].ToString());

            txtInitials.Text = String.Empty;
                
        }
         
        private void UploadToServer(string ID)
    {
        byte[] oStream = getStream(txtInitials.Text);

        SqlConnection con = new SqlConnection("server=tkcbt.korteco.com;uid=intranet;pwd=popzombie;database=Viewpoint");
        SqlCommand cmd = new SqlCommand("Update Intranet.dbo.KTUser set Initials = @Initials where UserID = '" + ID + "'", con);
        cmd.CommandType = CommandType.Text;

        cmd.Parameters.Add("@Initials", SqlDbType.Image, oStream.Length).Value = oStream;
        con.Open();
        cmd.ExecuteNonQuery();

        lblMsg.Text = "Initials upload complete";

        try
        {

            cmd.CommandType = CommandType.Text;           
            cmd.ExecuteNonQuery();            
            con.Close();
            
        }
        catch (Exception ex)
        {
            try
            {
                con.Close();
            }
            catch (Exception ex2)
            {
                throw (ex2);
            }
            throw (ex);


        }
    }


        

        public static byte[] getStream(string filePath)
        {
            FileStream stream = new FileStream(
                filePath, FileMode.Open, FileAccess.Read);
            BinaryReader reader = new BinaryReader(stream);

            byte[] photo = reader.ReadBytes((int)stream.Length);

            reader.Close();
            stream.Close();

            return photo;

            
        }



    }
}
