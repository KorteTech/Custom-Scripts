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
    public partial class frmSoftware : Form
    {
        public frmSoftware()
        {
            InitializeComponent();
            //load the combo box
            UploadToServer();
        }

            
        private void UploadToServer()
        {


            SqlConnection con = new SqlConnection("server=tkcbt.korteco.com;uid=intranet;pwd=popzombie;database=Intranet");
            //SqlCommand cmd = new SqlCommand("select * from KTSoftwareInvoices where Path is not null", con);
            SqlCommand cmd = new SqlCommand("SELECT* FROM[Intranet].[dbo].[KTAsset] where InvoicePath is not null", con);
            
            cmd.CommandType = CommandType.Text;

            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                try
                {
                    //byte[] oStream = getStream(@"\\tkcwebs\Static\Assets\SoftwareInvoices\" + dr["Path"].ToString());
                    byte[] oStream = getStream(@"\\tkcwebs\Static\Assets\AssetInvoices\" + dr["InvoicePath"].ToString());

                    SqlConnection con2 = new SqlConnection("server=tkcbt.korteco.com;uid=intranet;pwd=popzombie;database=Intranet");
                    SqlCommand cmd2 = new SqlCommand("Intranet.dbo.[AddAttachment]", con2);
                    cmd2.CommandType = CommandType.StoredProcedure;
                    con2.Open();
                    cmd2.Parameters.AddWithValue("RptID", dr["AssetID"].ToString());
                    //cmd2.Parameters.AddWithValue("RptID", dr["SoftwareID"].ToString());
                    cmd2.Parameters.AddWithValue("SystemID", 4);
                    //cmd2.Parameters.AddWithValue("SystemID", 5);
                    cmd2.Parameters.AddWithValue("Attachment", oStream);
                    cmd2.Parameters.AddWithValue("Description", "bk" + dr["InvoicePath"].ToString());
                    cmd2.Parameters.AddWithValue("DocTypeID", 1);
                    //cmd2.Parameters.AddWithValue("DocTypeID", 4);

                    foreach (SqlParameter p in cmd2.Parameters)
                    {
                        if (p.Value == null)
                            p.Value = DBNull.Value;
                    }

                    cmd2.ExecuteNonQuery();
                    con2.Close();
                }
                catch { }
            }
            con.Close();
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
