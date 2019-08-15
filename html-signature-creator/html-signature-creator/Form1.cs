using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace html_signature_creator
{
    public partial class Form1 : Form        
    {
        string _path;

        public Form1()
        {
            InitializeComponent();
            //lblStatus.Text = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            
        }

        private void btnSaveSignature_Click(object sender, EventArgs e)
        {
            lblStatus.ForeColor = Color.Black;
            lblStatus.Text="Working...";
            createFile();
            Uri uriPath = new Uri(_path);

            wbSignature.Url = uriPath;
            lblStatus.Text = "Korte Signature created at " + _path;
        }

        private void createFile()
        {
            _path=Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\Microsoft\Signatures\";
            string company="";

            if (rbTKC.Checked)
                company = "TKC";
            if (rbDesign.Checked)
                company = "Design";
            if (rbTKCDesign.Checked)
                company = "TKCDesign";
            if (rbTKCArch.Checked)
                company = "TKCArch";
            if (rbIAL.Checked)
                company = "IAL";
            try
            {
                DirectoryInfo di = new DirectoryInfo(_path);
                if (!di.Exists)
                    di.Create();
            }
            catch(Exception ex)
            {
                lblStatus.Text += "Error creating folder.";
                lblStatus.ForeColor = Color.Red;
            }

            switch (company)
            {
                case "TKC": _path += "Korte"; break;
                case "Design": _path += "Korte Design"; break;
                case "TKCDesign": _path += "TKC Design"; break;
                case "TKCArch": _path += "TKC Arch"; break;
                case "IAL": _path += "IAL"; break;
            }
            _path += " Signature.htm";
            
            string phoneNumbers="";

            if (comboNum1Type.Text != "")
                phoneNumbers += "<b>" + comboNum1Type.Text + "</b>: " + txtNumber1.Text + "<br />";
            if (comboNum2Type.Text != "")
                phoneNumbers += "<b>" + comboNum2Type.Text + "</b>: " + txtNumber2.Text + "<br />";
            if (comboNum3Type.Text != "")
                phoneNumbers += "<b>" + comboNum3Type.Text + "</b>: " + txtNumber3.Text + "<br />";

            string divider = (txtCred.Text != "") ? "|" : ""; 
            try
            {
                using (FileStream fs = File.Create(_path))
                {

                    //AddText(fs, "<html><body>\n");
                    AddText(fs, "<html xmlns='http://www.w3.org/1999/xhtml' xmlns:v='urn:schemas-microsoft-com:vml' xmlns:o='urn:schemas-microsoft-com:office:office'>\n");
                    AddText(fs, "<!--[if gte mso 9]>\n");
                    AddText(fs, "<xml>\n");
                    AddText(fs, "<o:OfficeDocumentSettings>\n");
                    AddText(fs, "<o:AllowPNG/>\n");
                    AddText(fs, "<o:PixelsPerInch>96</o:PixelsPerInch>\n");
                    AddText(fs, "</o:OfficeDocumentSettings>\n");
                    AddText(fs, "</xml>\n");
                    AddText(fs, "<![endif]-->\n");
                    AddText(fs, "<body>\n");
                    AddText(fs, "<div id='divSigPreview'>\n");
                    AddText(fs, "<table border='0' cellpadding='0' cellspacing='15'>\n");
                    AddText(fs, "<tr valign='top'>\n");
                    switch (company)
                    {
                        case "TKC":
                            {
                                AddText(fs, "<td valign='middle'><a href='http://www.korteco.com/'><img src='http://www.korteco.com/email-sig/korte.jpg' width='153' style='width:153px;height=51px' height='51' border='0' alt='The Korte Company' /></a></td>\n");
                                break;
                            }
                        case "Design":
                            {
                                AddText(fs, "<td valign='middle'><a href='http://www.korteco.com/'><img src='http://www.korteco.com/email-sig/korte-design.jpg' width='151' style='width:151px;height=54px' height='54' border='0' alt='The Korte Company' /></a></td>\n");
                                break;
                            }
                        case "TKCDesign":
                            {
                                AddText(fs, "<td valign='middle'><a href='http://www.korteco.com/'><img src='http://www.korteco.com/email-sig/tkc-design.jpg' width='160' style='width:160px;height=68px' height='68' border='0' alt='The Korte Company' /></a></td>\n");
                                break;
                            }
                        case "TKCArch":
                            {
                                AddText(fs, "<td valign='middle'><a href='http://www.korteco.com/'><img src='http://www.korteco.com/email-sig/tkc-arch.jpg' width='160' style='width:160px;height=68px' height='68' border='0' alt='The Korte Company' /></a></td>\n");
                                break;
                            }
                        case "IAL":
                            {
                                AddText(fs, "<td valign='middle'><a href='http://www.korteco.com/'><img src='http://www.korteco.com/email-sig/ial.jpg' width='152' style='width:152px;height=47px' height='47' border='0' alt='The Korte Company' /></a></td>\n");                                break;
                            }
                        default:
                            {
                                lblStatus.Text = "Error with company selection.";
                                lblStatus.ForeColor = Color.Red;
                                return;
                            }

                    }
                    AddText(fs, "<td style='padding: 0 15px;'>\n");
                    AddText(fs, "  <img src='http://www.korteco.com/email-sig/vert-divider.jpg' />\n");
                    AddText(fs, "</td>\n");
                    AddText(fs, "<td rowspan='2'>\n");
                    AddText(fs, "<span style='font-size:7.5pt;font-family:Arial,sans-serif;mso-fareast-font-family:Calibri'>\n");
                    AddText(fs, "<b>" + txtName.Text + "</b>&nbsp;" + divider + "&nbsp;" + txtCred.Text + "<br/ >" + txtTitle.Text + "<br />\n");
                    AddText(fs, phoneNumbers + "\n");
                    AddText(fs, "</span>\n");
                    AddText(fs, "<span style='font-size:3.5pt;font-family:Arial,sans-serif;'>&nbsp;<br/></span>\n");
                    AddText(fs, "<span style='font-size:7.5pt;font-family:Arial,sans-serif;mso-fareast-font-family:Calibri'>\n");
                    AddText(fs, "  <b>Build Smart</b> at <a style='color:#f68428;' href='http://www.korteco.com/'>korteco.com</a><br />\n");
                    AddText(fs, "</span>\n");
                    AddText(fs, "<span style='font-size:3.5pt;font-family:Arial,sans-serif;'>&nbsp;<br/></span>\n");
                    AddText(fs, "<div style='padding-top:1em;line-height:14px;'>\n");
                    AddText(fs, "  <a href='http://www.facebook.com/TheKorteCompany'><img style='padding-right: 10px;' src='http://www.korteco.com/email-sig/facebook.jpg' width='8' height='15' style='width:8px;height=15px' border='0' alt='Like us on Facebook' /></a>&nbsp;&nbsp;\n");
                    AddText(fs, "  <a href='http://twitter.com/#!/KorteGreenBuild'><img style='padding-right: 10px;' src='http://www.korteco.com/email-sig/twitter.jpg' width='17' height='15' style='width:17px;height=15px' border='0' alt='Follow us on Twitter' /></a>&nbsp;&nbsp;\n");
                    AddText(fs, "  <a href='http://www.linkedin.com/company/95558'><img src='http://www.korteco.com/email-sig/linkedin.jpg' width='15' height='15' style='width:15px;height=15px' border='0' alt='Lets connect on LinkedIn' /></a>\n");
                    AddText(fs, "</div>\n");
                    AddText(fs, "</td>\n");
                    AddText(fs, "</tr>\n");
                    AddText(fs, "</table>\n");
                    AddText(fs, "</div>\n");
                    AddText(fs, "</body></html>\n");

                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "Error creating signature file.";
                lblStatus.ForeColor = Color.Red;
            }
        }

        private static void AddText(FileStream fs, string value)
        {
            byte[] info = new UTF8Encoding(true).GetBytes(value);
            fs.Write(info, 0, info.Length);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            lblStatus.Text = "";
         
        }

        

        private void lblStatus_Click(object sender, EventArgs e)
        {

        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}
