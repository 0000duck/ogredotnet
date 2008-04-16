using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

using OgreDotNet;

namespace DemoWinForms
{
    /// <summary>
    /// Summary description for Form1.
    /// </summary>
    public class Form1 : Form
    {
        protected App app = null;

        private Panel panel1;
        private ListBox listBox1;
        private Button button1;
        private Button button2;
        private MainMenu mainMenu1;
        private MenuItem menuItem1;
        private MenuItem menuItem2;
        private MenuItem menuItem3;
        private MenuItem menuItem4;
        private MenuItem menuItem5;
        private MenuItem menuItem6;
        private MenuItem menuItem7;
        private MenuItem menuItem8;
        private MenuItem menuItem9;
        private MenuItem menuItem10;
        private MenuItem menuItem11;
        private MenuItem menuItem12;
        private MenuItem menuItem13;
        private MenuItem menuItem14;
        private MenuItem menuItem15;
        private MenuItem menuItem16;
        private MenuItem menuItem17;
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private Container components = null;

        public Form1()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            //app = new App(this.panel1);
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (components != null) 
                {
                    components.Dispose();
                }
            }
            base.Dispose (disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panel1 = new Panel();
            this.mainMenu1 = new MainMenu();
            this.menuItem1 = new MenuItem();
            this.menuItem2 = new MenuItem();
            this.listBox1 = new ListBox();
            this.button1 = new Button();
            this.button2 = new Button();
            this.menuItem3 = new MenuItem();
            this.menuItem4 = new MenuItem();
            this.menuItem5 = new MenuItem();
            this.menuItem6 = new MenuItem();
            this.menuItem7 = new MenuItem();
            this.menuItem8 = new MenuItem();
            this.menuItem9 = new MenuItem();
            this.menuItem10 = new MenuItem();
            this.menuItem11 = new MenuItem();
            this.menuItem12 = new MenuItem();
            this.menuItem13 = new MenuItem();
            this.menuItem14 = new MenuItem();
            this.menuItem15 = new MenuItem();
            this.menuItem16 = new MenuItem();
            this.menuItem17 = new MenuItem();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Location = new Point(248, 8);
            this.panel1.Name = "panel1";
            this.panel1.Size = new Size(480, 440);
            this.panel1.TabIndex = 0;
            this.panel1.Paint += new PaintEventHandler(this.panel1_Paint);
            // 
            // mainMenu1
            // 
            this.mainMenu1.MenuItems.AddRange(new MenuItem[] {
                    this.menuItem1,
                    this.menuItem9,
                    this.menuItem13});
            // 
            // menuItem1
            // 
            this.menuItem1.Index = 0;
            this.menuItem1.MenuItems.AddRange(new MenuItem[] {
                    this.menuItem3,
                    this.menuItem4,
                    this.menuItem5,
                    this.menuItem6,
                    this.menuItem7,
                    this.menuItem8,
                    this.menuItem2});
            this.menuItem1.Text = "&File";
            // 
            // menuItem2
            // 
            this.menuItem2.Index = 6;
            this.menuItem2.Text = "&Quit";
            this.menuItem2.Click += new System.EventHandler(this.menuItem2_Click);
            // 
            // listBox1
            // 
            this.listBox1.Items.AddRange(new object[] {
                    "This",
                    "Is",
                    "A",
                    "Demo",
                    "Of",
                    "Ogre",
                    "In",
                    "A",
                    ".NET",
                    "Form"});
            this.listBox1.Location = new Point(8, 8);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new Size(232, 381);
            this.listBox1.TabIndex = 1;
            // 
            // button1
            // 
            this.button1.Location = new Point(16, 400);
            this.button1.Name = "button1";
            this.button1.Size = new Size(104, 56);
            this.button1.TabIndex = 2;
            this.button1.Text = "button1";
            // 
            // button2
            // 
            this.button2.Location = new Point(128, 400);
            this.button2.Name = "button2";
            this.button2.Size = new Size(112, 56);
            this.button2.TabIndex = 3;
            this.button2.Text = "button2";
            // 
            // menuItem3
            // 
            this.menuItem3.Index = 0;
            this.menuItem3.Text = "&New";
            // 
            // menuItem4
            // 
            this.menuItem4.Index = 1;
            this.menuItem4.Text = "-";
            // 
            // menuItem5
            // 
            this.menuItem5.Index = 2;
            this.menuItem5.Text = "&Open";
            // 
            // menuItem6
            // 
            this.menuItem6.Index = 3;
            this.menuItem6.Text = "&Save";
            this.menuItem6.Click += new System.EventHandler(this.menuItem6_Click);
            // 
            // menuItem7
            // 
            this.menuItem7.Index = 4;
            this.menuItem7.Text = "Save &As";
            // 
            // menuItem8
            // 
            this.menuItem8.Index = 5;
            this.menuItem8.Text = "-";
            // 
            // menuItem9
            // 
            this.menuItem9.Index = 1;
            this.menuItem9.MenuItems.AddRange(new MenuItem[] {
                    this.menuItem10,
                    this.menuItem11,
                    this.menuItem12});
            this.menuItem9.Text = "&Edit";
            // 
            // menuItem10
            // 
            this.menuItem10.Index = 0;
            this.menuItem10.Text = "&Cut";
            // 
            // menuItem11
            // 
            this.menuItem11.Index = 1;
            this.menuItem11.Text = "C&opy";
            // 
            // menuItem12
            // 
            this.menuItem12.Index = 2;
            this.menuItem12.Text = "&Paste";
            // 
            // menuItem13
            // 
            this.menuItem13.Index = 2;
            this.menuItem13.MenuItems.AddRange(new MenuItem[] {
                    this.menuItem14,
                    this.menuItem15,
                    this.menuItem17,
                    this.menuItem16});
            this.menuItem13.Text = "&Help";
            // 
            // menuItem14
            // 
            this.menuItem14.Index = 0;
            this.menuItem14.Text = "&Help";
            // 
            // menuItem15
            // 
            this.menuItem15.Index = 1;
            this.menuItem15.Text = "&Reference";
            // 
            // menuItem16
            // 
            this.menuItem16.Index = 3;
            this.menuItem16.Text = "&About";
            // 
            // menuItem17
            // 
            this.menuItem17.Index = 2;
            this.menuItem17.Text = "-";
            // 
            // Form1
            // 
            this.AutoScaleBaseSize = new Size(5, 13);
            this.ClientSize = new Size(736, 462);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.panel1);
            this.Menu = this.mainMenu1;
            this.Name = "Form1";
            this.Text = "Ogre in a .NET Form";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
        }

        #endregion

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main() 
        {
            using (Form1 frm = new Form1())
            {
                frm.Show();

                App app = new App(frm.panel1);

                while (frm.Created)
                {
                    app.Root.RenderOneFrame();
                    app.RenderWindow.Update();
                    Application.DoEvents();
                }

                app.Root.Dispose();
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {
        }

        private void menuItem2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void menuItem6_Click(object sender, EventArgs e)
        {
        }
    }
}
