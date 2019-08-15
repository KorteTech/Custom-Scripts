using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;

namespace APUploadInitials
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            loadUsers();
        }

        private class User
        {
            public string UserID { get; set; }            
            public string Name { get; set; }
 
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            lblStatus.Text = "";
            dlgInitials.ShowDialog();
        }

        private void AddEmployee(string fileName, int userId)
        {
            try
            {
                //byte[] oStream = getStream(@"C:\Users\Public\Documents\Employee Initials\SusanBowmanInitials.png");
                byte[] oStream = getStream(@fileName);

                SqlConnection con = new SqlConnection("server=tkcbt.korteco.com;uid=intranet;pwd=popzombie;database=Viewpoint");
                SqlCommand cmd = new SqlCommand("Update Intranet.dbo.KTUser set Initials = @Initials where UserID = " + userId, con);
                cmd.CommandType = CommandType.Text;

                cmd.Parameters.Add("@Initials", SqlDbType.Image, oStream.Length).Value = oStream;
                con.Open();
                cmd.ExecuteNonQuery();
                lblStatus.Text = "Updated initials for " + lbUsers.GetItemText(lbUsers.SelectedItem);
            }
            catch (Exception e)
            {
                lblStatus.Text = e.Message.ToString();
            }
        }

        private void loadUsers()
        {
            try
            {


                string Sql = "select UserID, Name from Intranet.dbo.KTUser where NonUser = 0 and ActiveYN = 'Y' order by Name";
                SqlConnection con = new SqlConnection("server=192.168.1.23;uid=intranet;pwd=popzombie;database=Viewpoint");
                SqlCommand cmd = new SqlCommand(Sql, con);
                con.Open();
                SqlDataReader DR = cmd.ExecuteReader();

                List<User> users = new List<User>();
                while (DR.Read())
                {
                    users.Add(new User { UserID = DR["UserID"].ToString(), Name = DR["Name"].ToString() });

                    //cboUser.Items.Add(new ListItem DR[0]);
                }
                lbUsers.DisplayMember = "Name";
                lbUsers.ValueMember = "UserID";
                lbUsers.DataSource = users;
            }
            catch (Exception e) {
                MessageBox.Show(e.Message);
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

        private void btnUpload_Click(object sender, EventArgs e)
        {
            int vint;
            int userid = int.TryParse(lbUsers.SelectedValue.ToString(), out vint) ? vint : 0;
            AddEmployee(dlgInitials.FileName, userid);
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FileOk(object sender, CancelEventArgs e)
        {
            txtFile.Text = dlgInitials.FileName;
        }
    }
}
