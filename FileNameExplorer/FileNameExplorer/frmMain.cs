using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
//using ;
using System.Threading;
using Delimon.Win32.IO;
using System.Text.RegularExpressions;

namespace FileNameExplorer
{
    public partial class frmMain : Form
    {

        bool exit;
        ProgressBar pbar = new ProgressBar();
        int filecountProgress;        
 
        public frmMain()
        {
            InitializeComponent();
            initializeStuff();
            this.ActiveControl = txtFolder;
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
        
            //reset variables
            exit = false;
            filecountProgress = 0;
            pbar.Value = 0;

            DirectoryInfo rootDir = new DirectoryInfo(txtFolder.Text);
            
            //get count of all files in all directories for the progress bar
            pbar.Maximum =  Delimon.Win32.IO.Directory.GetFiles(txtFolder.Text, "*.*", SearchOption.AllDirectories).Length;
            
            WalkDirectoryTree(rootDir);
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            try
            {
                FolderBrowserDialog fbd = new FolderBrowserDialog();
                DialogResult result = fbd.ShowDialog();

                string[] files = Directory.GetFiles(fbd.SelectedPath);
                txtFolder.Text = fbd.SelectedPath;
                
            }
            catch { }
        }


        private void initializeStuff()
        {
            lvError.View = View.Details;
            lvError.Columns.Add("File Name", -1, HorizontalAlignment.Left);
            lblCount.Text = "";
            lblError.Text = "";
            //lvNew.View = View.Details;
            //lvNew.Columns.Add("File Name", -1, HorizontalAlignment.Left);
            
            //initialize progress bar

            tblPanel.Controls.Add(pbar, 0, 2);
            
            //Controls.Add(pbar);
            pbar.Visible = true;
            pbar.Location = new System.Drawing.Point(15, 450);
            pbar.Width = 459;
            pbar.Height = 23;
            pbar.Minimum = 0;                        
            pbar.Step = 1;
            pbar.TabIndex = 1;

        }
         //private void Form1_Load(object sender, System.EventArgs e)
         //   {
         //       // Start the BackgroundWorker.
         //       backgroundWorker1.RunWorkerAsync();
         //   }



        //private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        //{
            
        //        for (int i = 1; i <= 100; i++)
        //        {
        //            // Wait 100 milliseconds.
        //            Thread.Sleep(100);
        //            // Report progress.
        //            backgroundWorker1.ReportProgress(i);
        //        }

        //}   
        //public void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        //    {
        //        // Change the value of the ProgressBar to the BackgroundWorker progress.
        //        pbar.Value = e.ProgressPercentage;
        //        // Set the text.
        //        this.Text = e.ProgressPercentage.ToString();
        //    }

        
        public void WalkDirectoryTree(DirectoryInfo root)
        {
            
            string[] files = null;
            DirectoryInfo[] subDirs = null;
            //declare boolean here to determine if they cancelled out            
            // First, process all the files directly under this folder 
            try
            {
                files = Directory.GetFiles(root.FullName);
            }
            // This is thrown if even one of the files requires permissions greater 
            // than the application provides. 
            catch (UnauthorizedAccessException e)
            {
                // This code just writes out the message and continues to recurse. 
                // You may decide to do something different here. For example, you 
                // can try to elevate your privileges and access the file again.
                Console.WriteLine(e.Message);
            }

            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            

            {
                foreach (string file in files)
                {
                    // In this example, we only access the existing FileInfo object. If we 
                    // want to open, delete or modify the file, then 
                    // a try-catch block is required here to handle the case 
                    // where the file has been deleted since the call to TraverseTree().
                    //Console.WriteLine(fi.FullName);
                    lblError.Text = file;
                    lblCount.Text = filecountProgress.ToString(); // file;
                    filecountProgress++;
                    pbar.PerformStep();
                    //if (pbar.Value % 50 == 0)
                    //    MessageBox.Show(pbar.Value.ToString());

                    //pbar.Refresh();
                    Application.DoEvents();

                    //if (files != null)
                    //int percent = (pbar.Value / pbar.Maximum) * 100;

                    if (file.Length >= 235)
                    {
                        var lvErrorItem = new ListViewItem(file);
                        lvError.Items.Add(lvErrorItem);

                        //var lvNewItem = new ListViewItem(file);

                        //string trimmedFileName = file.Substring(0, file.Length);
                        //lvNewItem = new ListViewItem(trimmedFileName);
                        //lvNew.Items.Add(lvNewItem);

                        // split the path into an array and look for the longest name (folder name or file name, we dont care)
                        string[] x = file.Split('\\');
                        x[1] = "";
                        //x[x.Count() - 1] = "";
                        var orderedNames = x.OrderBy(name => name.Length);
                        
                        string longestName = orderedNames.Last();
                        //string longestName = "";
                                                

                        lvError.AutoResizeColumn(0, ColumnHeaderAutoResizeStyle.ColumnContent);
                        //lvNew.AutoResizeColumn(0, ColumnHeaderAutoResizeStyle.ColumnContent);

                        //create new form for user to change the name of the longest part of the path                      
                        frmInput input = new frmInput();

                        //input.txtNewName.Text = longestName;
                        //input.fileCharCount = file.Length;


                        //input.ShowDialog();

                        //if (input.CancelClick == true)
                        //{

                        //    DialogResult dialogResult = MessageBox.Show("Are you sure you want to cancel? All unsaved changes will be deleted.", "Warning", MessageBoxButtons.YesNo);

                        //    if (dialogResult == DialogResult.Yes)
                        //    {
                        //        input.Close();
                        //        //set the variable that tells you that they want out
                        //        exit = true;
                        //        break;
                        //    }
                        //}

                        //if i hit cancel, get out of the loop

                        //if (input.txtNewName.Text != "" && input.txtNewName.Text != longestName)
                        //{

                        //    //File.Move(fi.FullName, Path.Combine(fo.Directory.ToString()+"_"+ fo.Name));

                        //    string oldPath = file.Substring(0, file.IndexOf(longestName)) + longestName;
                        //    string newPath = file.Substring(0, file.IndexOf(longestName)) + input.txtNewName.Text;
                            

                        //    lvError.Items.Clear();
                        //    lvNew.Items.Clear();

                        //    DirectoryInfo currentdir = new DirectoryInfo(oldPath);
                        //    currentdir.MoveTo(newPath);                            
                        //}
                        //if (longestName == x[x.Count() - 1])
                            //root = new DirectoryInfo(txtFolder.Text);
                            ////break;                        
                    }

                    //// Now find all the subdirectories under this directory.
                    //subDirs = root.GetDirectories();

                    //foreach (DirectoryInfo dirInfo in subDirs)
                    //{
                    //    // Resursive call for each subdirectory.
                    //    WalkDirectoryTree(dirInfo);
                    //}

                }



                //check the variable that you set - if they want out, don't execute this.
                // bool iquit = false;
                // if (!iquit) -- means if (iquit == false)
                // if (iquit) --means if (iquit == true)
                if (!exit)
                {

                    // Now find all the subdirectories under this directory.
                    subDirs = root.GetDirectories();

                    foreach (DirectoryInfo dirInfo in subDirs)
                    {
                        // Resursive call for each subdirectory.
                        WalkDirectoryTree(dirInfo);
                        if (exit)

                            break;
                    }
                }

            }
            
        }

        private void lvError_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        

        }
    }


       
        
