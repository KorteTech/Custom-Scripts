using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace FileNameExplorer
{
    public partial class frmInput : Form
    {
        public bool CancelClick = false;
        public int fileCharCount;
        public int fileCharCountBasis;

        public frmInput()
        {
            InitializeComponent();                        
        }

        public void btnOk_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            CancelClick = true; 
        }

        private void frmInput_Load(object sender, EventArgs e)
        {
            fileCharCountBasis = fileCharCount - txtNewName.Text.Length;
            lblCount.Text = fileCharCount.ToString();
        }

        private void keyup(object sender, KeyEventArgs e)
        {
            int intCount = 0;

            foreach (char ch in txtNewName.Text)
            {
                intCount++;
            }

            int totalCharCount = intCount + fileCharCountBasis;

            lblCount.Text = totalCharCount.ToString();
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            
        }


   }

}
