package Portal;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class SchoolPortal extends JFrame {
    private static final Color DARK_GREEN = new Color(22, 54, 105);
    private static final Color GREEN = new Color(35, 101, 190);
    private static final Color PALE = new Color(242, 247, 255);
    private static final Color TEXT = Color.BLACK;
    private static final Font NORMAL = new Font("SansSerif", Font.PLAIN, 12);
    private static final Font BOLD = new Font("SansSerif", Font.BOLD, 13);

    
    private static final int ADMIN_ID = 1;

    private final ArrayList<Student> students = new ArrayList<>();
    private final ArrayList<Student.ClearanceRecord> clearances = new ArrayList<>();
    private final ArrayList<Student.PaymentRecord> payments = new ArrayList<>();
    private final ArrayList<Student.AnnouncementRecord> announcements = new ArrayList<>();

    private final CardLayout cardLayout = new CardLayout();
    private final JPanel pagePanel = new JPanel(cardLayout);

    private DefaultTableModel studentModel, clearanceModel, paymentModel, announcementModel;
    private JTable studentTable, clearanceTable, paymentTable, announcementTable;
    private JLabel dashboardStudents, dashboardPending, dashboardPayments, dashboardAnnouncements;
    private JLabel statusLabel;

    public SchoolPortal() {
        setTitle("School Portal | Student and Clearance Management");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(1250, 760);
        setMinimumSize(new Dimension(1050, 650));
        setLocationRelativeTo(null);
        loadSampleData();
        buildLayout();
        refreshAllTables();
        showPage("Dashboard");
        setVisible(true);
    }

   
    private void loadSampleData() {
        students.add(new Student("2024-001", "Maria", "Santos", "BSIT", "2nd Year",
                "Female", "2005-04-12", "maria.santos@school.edu", "09171234567",
                "San Jose del Monte, Bulacan", "Liza Santos", "Mother", "09179876543"));
        students.add(new Student("2024-002", "Juan", "Dela Cruz", "BSBA", "2nd Year",
                "Male", "2004-11-02", "juan.delacruz@school.edu", "09181234567",
                "Quezon City", "Ramon Dela Cruz", "Father", "09189998877"));
        students.add(new Student("2024-003", "Ana", "Reyes", "BSA", "3rd Year",
                "Female", "2003-08-19", "ana.reyes@school.edu", "09201234567",
                "Meycauayan, Bulacan", "Mila Reyes", "Mother", "09205554433"));
        students.add(new Student("2024-004", "Carlo", "Garcia", "BSCE", "4th Year",
                "Male", "2002-06-07", "carlo.garcia@school.edu", "09221234567",
                "Marilao, Bulacan", "Jose Garcia", "Father", "09227776655"));
        students.add(new Student("2024-005", "Ella", "Cruz", "BSN", "1st Year",
                "Female", "2006-01-25", "ella.cruz@school.edu", "09231234567",
                "Bocaue, Bulacan", "Rina Cruz", "Mother", "09234445566"));
                 students.add(new Student("2024-006", "Paolo", "Mendoza", "BSIT", "1st Year",
                 "Male", "2006-03-14", "paolo.mendoza@school.edu", "09241234567",
                 "Balagtas, Bulacan", "Elena Mendoza", "Mother", "09241112233"));
         students.add(new Student("2024-007", "Kristine", "Bautista", "BSIT", "3rd Year",
                 "Female", "2003-12-05", "kristine.bautista@school.edu", "09251234567",
                 "Malolos, Bulacan", "Pedro Bautista", "Father", "09251112233"));
         students.add(new Student("2024-008", "Mark", "Villanueva", "BSBA", "2nd Year",
                 "Male", "2004-09-21", "mark.villanueva@school.edu", "09261234567",
                 "Caloocan City", "Nena Villanueva", "Mother", "09261112233"));
         students.add(new Student("2024-009", "Jasmine", "Navarro", "BSN", "1st Year",
                 "Female", "2006-07-30", "jasmine.navarro@school.edu", "09271234567",
                 "Guiguinto, Bulacan", "Ben Navarro", "Father", "09271112233"));
         students.add(new Student("2024-010", "Rico", "Salazar", "BSA", "4th Year",
                 "Male", "2002-02-18", "rico.salazar@school.edu", "09281234567",
                 "Pandi, Bulacan", "Teresa Salazar", "Mother", "09281112233"));
         
                     String[][] clearanceStatuses = {
             {"Cleared", "Cleared", "Cleared", "Pending", "Cleared", "Cleared"},
             {"Cleared", "Cleared", "Cleared", "Cleared", "Cleared", "Pending"},
             {"Cleared", "Cleared", "Pending", "Cleared", "Cleared", "Pending"},
             {"Cleared", "Cleared", "Cleared", "Cleared", "Cleared", "Cleared"},
             {"Pending", "Pending", "Pending", "Pending", "Cleared", "Pending"},
             {"Cleared", "Cleared", "Pending", "Pending", "Pending", "Pending"},
             {"Cleared", "Cleared", "Cleared", "Cleared", "Cleared", "Cleared"},
             {"Cleared", "Pending", "Cleared", "Cleared", "Pending", "Pending"},
             {"Pending", "Pending", "Pending", "Pending", "Pending", "Pending"},
             {"Cleared", "Cleared", "Cleared", "Cleared", "Cleared", "Pending"}
         };
         String[] offices = {"Registrar", "Library", "Accounting", "Clinic", "Guidance", "Student Affairs"};
         for (int i = 0; i < students.size(); i++) {

            Student.ClearanceRecord c = new Student.ClearanceRecord(
                    String.format("CL-%03d", i + 1), students.get(i).getStudentID(), ADMIN_ID);
             for (int j = 0; j < offices.length; j++) {
                 c.setStatus(offices[j], clearanceStatuses[i][j]);
            }
            clearances.add(c);
        }

        payments.add(new Student.PaymentRecord("2026-001", "2024-001", ADMIN_ID, "Laboratory Fee", 2500.00, "2026-02-10", "Paid"));
         payments.add(new Student.PaymentRecord("2026-002", "2024-002", ADMIN_ID, "Tuition Installment", 2500.00, "2026-02-11", "Paid"));
         payments.add(new Student.PaymentRecord("2026-003", "2024-003", ADMIN_ID, "Miscellaneous Fee", 1800.00, "2026-02-12", "Pending"));
         payments.add(new Student.PaymentRecord("2026-004", "2024-004", ADMIN_ID, "Laboratory Fee", 2500.00, "2026-02-14", "Paid"));
         payments.add(new Student.PaymentRecord("2026-005", "2024-005", ADMIN_ID, "Student Fee", 1200.00, "2026-02-15", "Pending"));
         payments.add(new Student.PaymentRecord("2026-006", "2024-006", ADMIN_ID, "Laboratory Fee", 2500.00, "2026-02-16", "Pending"));
         payments.add(new Student.PaymentRecord("2026-007", "2024-007", ADMIN_ID, "Tuition Installment", 3000.00, "2026-02-17", "Paid"));
         payments.add(new Student.PaymentRecord("2026-008", "2024-008", ADMIN_ID, "Miscellaneous Fee", 1800.00, "2026-02-18", "Paid"));
         payments.add(new Student.PaymentRecord("2026-009", "2024-009", ADMIN_ID, "Student Fee", 1200.00, "2026-02-19", "Pending"));
         payments.add(new Student.PaymentRecord("2026-010", "2024-010", ADMIN_ID, "Laboratory Fee", 2500.00, "2026-02-20", "Paid"));
         payments.add(new Student.PaymentRecord("2026-011", "2024-007", ADMIN_ID, "Laboratory Fee", 2500.00, "2026-02-21", "Paid"));
         payments.add(new Student.PaymentRecord("2026-012", "2024-005", ADMIN_ID, "Miscellaneous Fee", 1800.00, "2026-02-22", "Pending"));
         payments.add(new Student.PaymentRecord("2026-013", "2024-003", ADMIN_ID, "Student Fee", 1200.00, "2026-02-23", "Pending"));

        announcements.add(new Student.AnnouncementRecord("AN-001", ADMIN_ID, "No Classes on Feb 21",
                "There will be no classes on February 21. Please check official school updates.",
                "2026-02-18"));
        announcements.add(new Student.AnnouncementRecord("AN-002", ADMIN_ID, "Enrollment Schedule",
                "Enrollment for the next term starts on March 3, 2026.", "2026-02-16"));
        announcements.add(new Student.AnnouncementRecord("AN-003", ADMIN_ID, "Readmission Policy",
                "Please review the readmission policy for school year 2026-2027.", "2026-02-12"));
    }

    private void buildLayout() {
        JPanel root = new JPanel(new BorderLayout());
        root.setBackground(PALE);
        root.add(buildSidebar(), BorderLayout.WEST);

        JPanel right = new JPanel(new BorderLayout());
        right.setBackground(PALE);
        right.add(buildTopbar(), BorderLayout.NORTH);

        pagePanel.setBackground(PALE);
        pagePanel.add(buildDashboardPage(), "Dashboard");
        pagePanel.add(buildStudentsPage(), "Students");
        pagePanel.add(buildClearancePage(), "Clearance");
        pagePanel.add(buildPaymentsPage(), "Payments");
        pagePanel.add(buildAnnouncementsPage(), "Announcements");
        pagePanel.add(buildReportsPage(), "Reports");
        pagePanel.add(buildSettingsPage(), "Settings");
        right.add(pagePanel, BorderLayout.CENTER);

        root.add(right, BorderLayout.CENTER);
        setContentPane(root);
    }

    private JPanel buildSidebar() {
        JPanel side = new JPanel();
        side.setPreferredSize(new Dimension(295, 0));
        side.setBackground(new Color(220, 235, 255));
        side.setLayout(new BoxLayout(side, BoxLayout.Y_AXIS));

        JLabel logo = new JLabel("Clearance Portal", SwingConstants.CENTER);
        logo.setForeground(Color.BLACK);
        logo.setFont(new Font("SansSerif", Font.BOLD, 22));
        logo.setAlignmentX(Component.CENTER_ALIGNMENT);
        logo.setMaximumSize(new Dimension(260, 75));
        logo.setPreferredSize(new Dimension(260, 75));
        logo.setBorder(new EmptyBorder(22, 5, 25, 5));
        side.add(logo);

        String[] items = {"Dashboard", "Students", "Clearance", "Payments", "Announcements", "Reports", "Settings"};
        for (String item : items) {
            JButton button = new JButton(item);
            button.setAlignmentX(Component.CENTER_ALIGNMENT);
            button.setMaximumSize(new Dimension(245, 48));
            button.setPreferredSize(new Dimension(245, 48));
            button.setHorizontalAlignment(SwingConstants.LEFT);
            button.setFont(new Font("SansSerif", Font.BOLD, 12));
            button.setForeground(Color.BLACK);
            button.setBackground(new Color(220, 235, 255));
            button.setFocusPainted(false);
            button.setBorder(new EmptyBorder(8, 17, 8, 12));
            button.addActionListener(e -> showPage(item));
            side.add(button);
            side.add(Box.createVerticalStrut(8));
        }
        return side;
    }

    private JPanel buildTopbar() {
        JPanel top = new JPanel(new BorderLayout());
        top.setBackground(Color.WHITE);
        top.setBorder(new EmptyBorder(20, 25, 20, 25));
        JLabel title = new JLabel("San Isidro College");
        title.setFont(new Font("SansSerif", Font.BOLD, 22));
        title.setForeground(TEXT);
        JLabel account = new JLabel("School Year 2026–2027");
        account.setForeground(TEXT);
        top.add(title, BorderLayout.WEST);
        top.add(account, BorderLayout.EAST);
        return top;
    }

    private JPanel pageBase(String title, String subtitle) {
        JPanel page = new JPanel(new BorderLayout(0, 15));
        page.setBackground(PALE);
        page.setBorder(new EmptyBorder(22, 24, 22, 24));
        JPanel heading = new JPanel(new BorderLayout());
        heading.setOpaque(false);
        JLabel h = new JLabel(title);
        h.setFont(new Font("SansSerif", Font.BOLD, 23));
        h.setForeground(TEXT);
        JLabel sub = new JLabel(subtitle);
        sub.setFont(NORMAL);
        sub.setForeground(Color.BLACK);
        JPanel labels = new JPanel(new GridLayout(2, 1, 0, 4));
        labels.setOpaque(false);
        labels.add(h);
        labels.add(sub);
        heading.add(labels, BorderLayout.WEST);
        page.add(heading, BorderLayout.NORTH);
        return page;
    }

    private JPanel buildDashboardPage() {
        JPanel page = pageBase("Dashboard", "Welcome back! Here is the current portal overview.");
        JPanel body = new JPanel(new BorderLayout(0, 18));
        body.setOpaque(false);

        JPanel stats = new JPanel(new GridLayout(1, 4, 14, 0));
        stats.setOpaque(false);
        dashboardStudents = new JLabel("0");
        dashboardPending = new JLabel("0");
        dashboardPayments = new JLabel("0");
        dashboardAnnouncements = new JLabel("0");
        stats.add(statCard("Total Students", dashboardStudents, "Registered students"));
        stats.add(statCard("Pending Clearance", dashboardPending, "Need office approval"));
        stats.add(statCard("Unpaid Payments", dashboardPayments, "Pending receipts"));
        stats.add(statCard("Announcements", dashboardAnnouncements, "Posted notices"));

        JPanel lower = new JPanel(new GridLayout(1, 1, 14, 0));
        lower.setOpaque(false);
        JPanel activity = whitePanel("Recent Activities");
        JTextArea activityText = new JTextArea(
                "• Student records are available in Students.\n\n"
                + "• Office staff can update clearance statuses.\n\n"
                + "• Payment records can be marked Paid or Pending.\n\n"
                + "• Check Announcements for school reminders.");
        activityText.setEditable(false);
        activityText.setLineWrap(true);
        activityText.setWrapStyleWord(true);
        activityText.setForeground(Color.BLACK);
        activityText.setFont(NORMAL);
        activityText.setBackground(Color.WHITE);
        activity.add(activityText, BorderLayout.CENTER);
        lower.add(activity);

        body.add(stats, BorderLayout.NORTH);
        body.add(lower, BorderLayout.CENTER);
        page.add(body, BorderLayout.CENTER);
        return page;
    }

    private JPanel statCard(String title, JLabel number, String note) {
        JPanel card = new JPanel(new GridLayout(3, 1, 0, 5));
        card.setBackground(Color.WHITE);
        card.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(211, 224, 243)),
                new EmptyBorder(15, 16, 15, 16)));
        JLabel t = new JLabel(title); t.setForeground(TEXT); t.setFont(BOLD);
        number.setFont(new Font("SansSerif", Font.BOLD, 28)); number.setForeground(GREEN);
        JLabel n = new JLabel(note); n.setFont(NORMAL); n.setForeground(Color.BLACK);
        card.add(t); card.add(number); card.add(n);
        return card;
    }

    private JPanel buildStudentsPage() {
        JPanel page = pageBase("Students", "Manage student details and guardian contact information.");
        studentModel = model("Student ID", "First Name", "Last Name", "Course", "Year Level",
                "Gender", "Email", "Contact");
        studentTable = new JTable(studentModel);
        int[] studentColumnWidths = {90, 90, 100, 75, 85, 80, 245, 125};
        for (int i = 0; i < studentColumnWidths.length; i++) {
            studentTable.getColumnModel().getColumn(i).setPreferredWidth(studentColumnWidths[i]);
        }
        studentTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        JPanel tools = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        tools.setOpaque(false);
        JButton add = greenButton("+ Add Student");
        JButton edit = greenButton("Edit Selected");
        JButton delete = greenButton("Delete Selected");
        add.addActionListener(e -> studentDialog(null));
        edit.addActionListener(e -> editStudent());
        delete.addActionListener(e -> deleteStudent());
        tools.add(add); tools.add(edit); tools.add(delete);

        JPanel content = new JPanel(new BorderLayout(0, 12));
        content.setOpaque(false);
        content.add(tools, BorderLayout.NORTH);
        content.add(tableScroll(studentTable), BorderLayout.CENTER);
        page.add(content, BorderLayout.CENTER);
        return page;
    }

    private JPanel buildClearancePage() {
        JPanel page = pageBase("Clearance", "Update each office requirement. A student is cleared when every office is cleared.");
        clearanceModel = model("Clearance ID", "Student ID", "Student Name", "Registrar",
                "Library", "Accounting", "Clinic", "Guidance", "Student Affairs", "Overall", "Progress", "Admin ID");
        clearanceTable = new JTable(clearanceModel);
        int[] clearanceColumnWidths = {115, 100, 165, 100, 90, 115, 80, 100, 145, 95, 85, 90};
        for (int i = 0; i < clearanceColumnWidths.length; i++) {
            clearanceTable.getColumnModel().getColumn(i).setPreferredWidth(clearanceColumnWidths[i]);
        }
        clearanceTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
        for (int column = 3; column <= 9; column++) {
            clearanceTable.getColumnModel().getColumn(column).setCellRenderer(new StatusRenderer());
        }

        JPanel tools = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        tools.setOpaque(false);
        JButton update = greenButton("Update Office Status");
        update.addActionListener(e -> updateClearance());
        tools.add(update);

        JPanel content = new JPanel(new BorderLayout(0, 12));
        content.setOpaque(false);
        content.add(tools, BorderLayout.NORTH);
        content.add(tableScroll(clearanceTable), BorderLayout.CENTER);
        page.add(content, BorderLayout.CENTER);
        return page;
    }

    private JPanel buildPaymentsPage() {
        JPanel page = pageBase("Payments", "Track student fees, receipt numbers, payment dates, and payment status.");
        paymentModel = model("Receipt No.", "Student ID", "Student Name", "Description",
                "Amount (₱)", "Date", "Status", "Admin ID");
        paymentTable = new JTable(paymentModel);
        paymentTable.getColumnModel().getColumn(6).setCellRenderer(new StatusRenderer());

        JPanel tools = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        tools.setOpaque(false);
        JButton add = greenButton("+ Add Payment");
        JButton status = greenButton("Mark Paid / Pending");
        add.addActionListener(e -> addPayment());
        status.addActionListener(e -> changePaymentStatus());
        tools.add(add); tools.add(status);

        JPanel content = new JPanel(new BorderLayout(0, 12));
        content.setOpaque(false);
        content.add(tools, BorderLayout.NORTH);
        content.add(tableScroll(paymentTable), BorderLayout.CENTER);
        page.add(content, BorderLayout.CENTER);
        return page;
    }

    private JPanel buildAnnouncementsPage() {
        JPanel page = pageBase("Announcements", "Post school notices and reminders for students.");
        announcementModel = model("Announcement ID", "Title", "Message", "Date Posted", "Admin ID");
        announcementTable = new JTable(announcementModel);
        int[] announcementColumnWidths = {160, 190, 480, 120, 100};
        for (int i = 0; i < announcementColumnWidths.length; i++) {
            announcementTable.getColumnModel().getColumn(i).setPreferredWidth(announcementColumnWidths[i]);
        }
        announcementTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        JPanel tools = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        tools.setOpaque(false);
        JButton add = greenButton("+ New Announcement");
        add.addActionListener(e -> addAnnouncement());
        tools.add(add);

        JPanel content = new JPanel(new BorderLayout(0, 12));
        content.setOpaque(false);
        content.add(tools, BorderLayout.NORTH);
        content.add(tableScroll(announcementTable), BorderLayout.CENTER);
        page.add(content, BorderLayout.CENTER);
        return page;
    }

    private JPanel buildReportsPage() {
        JPanel page = pageBase("Reports", "A quick summary based on the records currently loaded in this demo.");
        JPanel cards = new JPanel(new GridLayout(0, 1, 0, 14));
        cards.setOpaque(false);
        cards.add(reportCard("Student List", "View registered students and their course details.", "Students"));
        cards.add(reportCard("Clearance Report", "Review overall status and office completion progress.", "Clearance"));
        cards.add(reportCard("Payments Report", "Review payment receipts and pending balances.", "Payments"));
        cards.add(reportCard("Announcements", "Review notices posted by the school admin.", "Announcements"));

        JPanel cardList = new JPanel(new BorderLayout());
        cardList.setOpaque(false);
        cardList.setBorder(new EmptyBorder(0, 24, 0, 24));
        cardList.add(cards, BorderLayout.NORTH);
        page.add(cardList, BorderLayout.CENTER);
        return page;
    }

    private JPanel reportCard(String title, String desc, String target) {
        JPanel p = new JPanel(new BorderLayout(0, 8));
        p.setBackground(Color.WHITE);
        p.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(235, 239, 245)),
                new EmptyBorder(12, 16, 12, 16)));
        JLabel t = new JLabel(title);
        t.setFont(BOLD);
        t.setForeground(TEXT);
        JLabel d = new JLabel("<html><div style=\"width:600px\">" + desc + "</div></html>");
        d.setFont(NORMAL);
        d.setForeground(TEXT);

        JButton b = greenButton("Open Report");
        b.setFont(new Font("SansSerif", Font.BOLD, 12));
        b.setPreferredSize(new Dimension(125, 30));
        b.setMinimumSize(new Dimension(125, 30));
        b.addActionListener(e -> showPage(target));

        JPanel details = new JPanel(new BorderLayout(0, 5));
        details.setOpaque(false);
        details.add(t, BorderLayout.NORTH);
        details.add(d, BorderLayout.CENTER);
        JPanel buttonRow = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
        buttonRow.setOpaque(false);
        buttonRow.add(b);

        p.add(details, BorderLayout.CENTER);
        p.add(buttonRow, BorderLayout.SOUTH);
        p.setPreferredSize(new Dimension(800, 112));
        return p;
    }

    private JPanel buildSettingsPage() {
        JPanel page = pageBase("Settings", "Basic profile and system information for the school administrator.");
        JPanel card = whitePanel("Administrator Profile");

        JPanel form = new JPanel(new GridBagLayout());
        form.setOpaque(false);
        form.setBorder(new EmptyBorder(15, 5, 10, 5));
        GridBagConstraints c = new GridBagConstraints();
        c.insets = new Insets(9, 8, 9, 8);
        c.fill = GridBagConstraints.HORIZONTAL;
        c.anchor = GridBagConstraints.WEST;

        
        String[] labels = {"Admin ID", "Full Name", "Email Address", "Role", "School Year"};
        String[] values = {String.valueOf(ADMIN_ID), "Ericka Magday", "magday28@school.edu", "Administrator", "2026–2027"};
        for (int i = 0; i < labels.length; i++) {
            c.gridx = 0;
            c.gridy = i;
            c.weightx = 0;
            JLabel label = new JLabel(labels[i]);
            label.setFont(NORMAL);
            form.add(label, c);

            c.gridx = 1;
            c.weightx = 1;
            JTextField field = new JTextField(values[i], 25);
            field.setFont(NORMAL);
            field.setForeground(Color.BLACK);
            field.setBackground(new Color(245, 247, 250));
            field.setPreferredSize(new Dimension(300, 32));
            field.setEditable(false);
            field.setFocusable(false);
            field.setCursor(Cursor.getDefaultCursor());
            field.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(200, 210, 225)),
                    new EmptyBorder(7, 10, 7, 10)));
            form.add(field, c);
        }

        c.gridx = 1;
        c.gridy = labels.length;
        c.weightx = 0;
        c.fill = GridBagConstraints.NONE;
        c.anchor = GridBagConstraints.WEST;

        JPanel actionButtons = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 0));
        actionButtons.setOpaque(false);
        JButton changePassword = new JButton("Change Password");
        changePassword.setFont(BOLD);
        changePassword.setForeground(Color.BLACK);
        changePassword.setBackground(new Color(220, 235, 255));
        changePassword.setFocusPainted(false);
        changePassword.setBorder(new EmptyBorder(9, 18, 9, 18));
        changePassword.addActionListener(e -> changePasswordDialog());

        JButton logout = new JButton("Log Out");
        logout.setFont(BOLD);
        logout.setForeground(Color.BLACK);
        logout.setBackground(new Color(255, 225, 225));
        logout.setFocusPainted(false);
        logout.setBorder(new EmptyBorder(9, 18, 9, 18));
        logout.addActionListener(e -> {
            int choice = JOptionPane.showConfirmDialog(
                    this,
                    "Are you sure you want to log out?",
                    "Confirm Log Out",
                    JOptionPane.YES_NO_OPTION,
                    JOptionPane.QUESTION_MESSAGE
            );
            if (choice == JOptionPane.YES_OPTION) {
                JOptionPane.showMessageDialog(
                        this,
                        "Thank You!",
                        "Log Out",
                        JOptionPane.INFORMATION_MESSAGE
                );
                dispose();
            }
        });
        actionButtons.add(changePassword);
        actionButtons.add(logout);
        form.add(actionButtons, c);

        JPanel content = new JPanel(new BorderLayout());
        content.setOpaque(false);
        content.add(form, BorderLayout.NORTH);
        card.add(content, BorderLayout.CENTER);
        page.add(card, BorderLayout.CENTER);
        return page;
    }
    private void changePasswordDialog(){
    JPasswordField currentPassword = new JPasswordField(20);
    JPasswordField newPassword = new JPasswordField(20);
    JPasswordField confirmPassword = new JPasswordField(20);
    JPanel panel = new JPanel(new GridLayout(0, 2, 8, 8));
    panel.add(new JLabel("Current Password:"));
    panel.add(currentPassword);
    panel.add(new JLabel("New Password:"));
    panel.add(newPassword);
    panel.add(new JLabel("Confirm New Password:"));
    panel.add(confirmPassword);
    
    int result = JOptionPane.showConfirmDialog(this, panel, "Change Password",
    JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
    if (result!= JOptionPane.OK_OPTION)return;
    
    String current = new String(currentPassword.getPassword());
    String newPass = new String (newPassword.getPassword());
    String confirm = new String (confirmPassword.getPassword());
    
    if(current.isEmpty() || newPass.isEmpty() || confirm.isEmpty()){
        message("Please fill all password fields.");
        return;
    }
    if (!newPass.equals(confirm)){
        message("The new password and confirmation do not match.");
        return;
    }
    if (newPass.length()<6){
        message("The new password must have at least 6 characters.");
        return;
    }
    if (Main.changeAdminPassword(current, newPass)){
        JOptionPane.showMessageDialog(this, "Password changed successfully.", 
                "Change Password", JOptionPane.INFORMATION_MESSAGE);
    }else{
        JOptionPane.showMessageDialog(this, "The current password is incorrect.", 
                "Change Password", JOptionPane.ERROR_MESSAGE);
    }
   }

    private JPanel whitePanel(String title) {
        JPanel p = new JPanel(new BorderLayout(0, 12));
        p.setBackground(Color.WHITE);
        p.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(211, 224, 243)),
                new EmptyBorder(16, 16, 16, 16)));
        JLabel label = new JLabel(title);
        label.setFont(BOLD);
        label.setForeground(TEXT);
        p.add(label, BorderLayout.NORTH);
        return p;
    }

    private JButton greenButton(String text) {
        JButton b = new JButton(text);
        b.setFont(BOLD);
        b.setForeground(Color.BLACK);
        b.setBackground(new Color(220, 235, 255));
        b.setFocusPainted(false);
        b.setBorder(new EmptyBorder(9, 13, 9, 13));
        return b;
    }

    private DefaultTableModel model(String... columns) {
        return new DefaultTableModel(columns, 0) {
            @Override public boolean isCellEditable(int row, int column) { return false; }
        };
    }

    private static class StatusRenderer extends DefaultTableCellRenderer {
        @Override
        public Component getTableCellRendererComponent(JTable table, Object value,
                boolean isSelected, boolean hasFocus, int row, int column) {
            Component component = super.getTableCellRendererComponent(
                    table, value, isSelected, hasFocus, row, column);
            String status = value == null ? "" : value.toString();
            setFont(new Font("SansSerif", Font.BOLD, 13));
            if (!isSelected) {
                if ("Cleared".equalsIgnoreCase(status) || "Paid".equalsIgnoreCase(status)) {
                    component.setForeground(new Color(0, 128, 0));
                } else if ("Pending".equalsIgnoreCase(status)) {
                    component.setForeground(Color.RED);
                } else {
                    component.setForeground(table.getForeground());
                }
            }
            return component;
        }
    }

    private JScrollPane tableScroll(JTable table) {
        table.setRowHeight(34);
        table.setFont(new Font("SansSerif", Font.PLAIN, 13));
        table.setForeground(new Color(35, 48, 68));
        table.setBackground(Color.WHITE);
        table.setGridColor(new Color(222, 231, 243));
        table.setShowGrid(true);
        table.getTableHeader().setFont(new Font("SansSerif", Font.BOLD, 13));
        table.getTableHeader().setForeground(Color.BLACK);
        table.getTableHeader().setBackground(new Color(220, 233, 251));
        table.getTableHeader().setPreferredSize(new Dimension(0, 38));
        table.setSelectionBackground(new Color(204, 223, 250));
        table.setSelectionForeground(Color.BLACK);
        table.setAutoResizeMode((table == studentTable || table == clearanceTable || table == announcementTable)
                ? JTable.AUTO_RESIZE_OFF : JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
        JScrollPane scroll = new JScrollPane(table);
        scroll.setBorder(BorderFactory.createLineBorder(new Color(211, 224, 243)));
        return scroll;
    }

    private void showPage(String name) {
        cardLayout.show(pagePanel, name);
        setTitle("Clearance Tracking Portal | " + name);
    }

    private Student findStudent(String id) {
        for (Student s : students) if (s.getStudentID().equals(id)) return s;
        return null;
    }

    private Student.ClearanceRecord findClearance(String studentID) {
        for (Student.ClearanceRecord c : clearances) if (c.getStudentID().equals(studentID)) return c;
        return null;
    }

    // ---------- auto numbering: one more than the highest existing number, so a deleted record never causes a duplicate ID ----------
    private int numberOf(String id, String prefix) {
        if (!id.startsWith(prefix)) return 0;
        try {
            return Integer.parseInt(id.substring(prefix.length()));
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private String nextClearanceId() {
        int max = 0;
        for (Student.ClearanceRecord c : clearances) max = Math.max(max, numberOf(c.getClearanceID(), "CL-"));
        return String.format("CL-%03d", max + 1);
    }

    private String nextReceiptNo() {
        int max = 0;
        for (Student.PaymentRecord p : payments) max = Math.max(max, numberOf(p.getReceiptNo(), "2026-"));
        return "2026-" + String.format("%03d", max + 1);
    }

    private String nextAnnouncementId() {
        int max = 0;
        for (Student.AnnouncementRecord a : announcements) max = Math.max(max, numberOf(a.getAnnouncementID(), "AN-"));
        return String.format("AN-%03d", max + 1);
    }

    private void refreshAllTables() {
        if (studentModel != null) {
            studentModel.setRowCount(0);
            for (Student s : students) studentModel.addRow(new Object[]{s.getStudentID(), s.getFirstName(),
                s.getLastName(), s.getCourse(), s.getYearLevel(), s.getGender(), s.getEmail(), s.getContact()});
        }
        if (clearanceModel != null) {
            clearanceModel.setRowCount(0);
            for (Student.ClearanceRecord c : clearances) {
                Student s = findStudent(c.getStudentID());
                clearanceModel.addRow(new Object[]{c.getClearanceID(), c.getStudentID(),
                    s == null ? "Unknown student" : s.getFullName(), c.getRegistrarStatus(),
                    c.getLibraryStatus(), c.getAccountingStatus(), c.getClinicStatus(),
                    c.getGuidanceStatus(), c.getStudentAffairsStatus(), c.getOverallStatus(),
                    c.getProgress() + "%", c.getAdminID()});
            }
        }
        if (paymentModel != null) {
            paymentModel.setRowCount(0);
            for (Student.PaymentRecord p : payments) {
                Student s = findStudent(p.getStudentID());
                paymentModel.addRow(new Object[]{p.getReceiptNo(), p.getStudentID(),
                    s == null ? "Unknown student" : s.getFullName(), p.getDescription(),
                    String.format("₱ %.2f", p.getAmount()), p.getDate(), p.getStatus(), p.getAdminID()});
            }
        }
        if (announcementModel != null) {
            announcementModel.setRowCount(0);
            for (Student.AnnouncementRecord a : announcements)
                announcementModel.addRow(new Object[]{a.getAnnouncementID(), a.getTitle(),
                    a.getMessage(), a.getDate(), a.getAdminID()});
        }
        if (dashboardStudents != null) dashboardStudents.setText(String.valueOf(students.size()));
        if (dashboardPending != null) {
            int pending = 0;
            for (Student.ClearanceRecord c : clearances) if ("Pending".equals(c.getOverallStatus())) pending++;
            dashboardPending.setText(String.valueOf(pending));
        }
        if (dashboardPayments != null) {
            int pending = 0;
            for (Student.PaymentRecord p : payments) if ("Pending".equals(p.getStatus())) pending++;
            dashboardPayments.setText(String.valueOf(pending));
        }
        if (dashboardAnnouncements != null) dashboardAnnouncements.setText(String.valueOf(announcements.size()));
    }

    private void studentDialog(Student existing) {
        JTextField id = new JTextField(existing == null ? "" : existing.getStudentID());
        JTextField first = new JTextField(existing == null ? "" : existing.getFirstName());
        JTextField last = new JTextField(existing == null ? "" : existing.getLastName());
        JComboBox<String> course = new JComboBox<>(new String[]{"BSIT", "BSCS", "BSBA", "BSA", "BSCE", "BSN", "BSED"});
        JComboBox<String> year = new JComboBox<>(new String[]{"1st Year", "2nd Year", "3rd Year", "4th Year", "5th Year"});
        JComboBox<String> gender = new JComboBox<>(new String[]{"Female", "Male", "Prefer not to say"});
        JTextField birth = new JTextField(existing == null ? "" : existing.getBirthDate());
        JTextField email = new JTextField(existing == null ? "" : existing.getEmail());
        JTextField contact = new JTextField(existing == null ? "" : existing.getContact());
        JTextField address = new JTextField(existing == null ? "" : existing.getAddress());
        JTextField guardian = new JTextField(existing == null ? "" : existing.getGuardian());
        JTextField relationship = new JTextField(existing == null ? "" : existing.getRelationship());
        JTextField guardianContact = new JTextField(existing == null ? "" : existing.getGuardianContact());

        if (existing != null) {
            id.setText(existing.getStudentID());
            id.setEditable(false);
            course.setSelectedItem(existing.getCourse());
            year.setSelectedItem(existing.getYearLevel());
            gender.setSelectedItem(existing.getGender());
        }

        JPanel panel = new JPanel(new GridLayout(0, 2, 8, 7));
        panel.add(new JLabel("Student ID*")); panel.add(id);
        panel.add(new JLabel("First Name*")); panel.add(first);
        panel.add(new JLabel("Last Name*")); panel.add(last);
        panel.add(new JLabel("Course")); panel.add(course);
        panel.add(new JLabel("Year Level")); panel.add(year);
        panel.add(new JLabel("Gender")); panel.add(gender);
        panel.add(new JLabel("Birth Date (YYYY-MM-DD)")); panel.add(birth);
        panel.add(new JLabel("Email")); panel.add(email);
        panel.add(new JLabel("Contact")); panel.add(contact);
        panel.add(new JLabel("Address")); panel.add(address);
        panel.add(new JLabel("Guardian")); panel.add(guardian);
        panel.add(new JLabel("Relationship")); panel.add(relationship);
        panel.add(new JLabel("Guardian Contact")); panel.add(guardianContact);

        int result = JOptionPane.showConfirmDialog(this, panel,
                existing == null ? "Add Student" : "Edit Student", JOptionPane.OK_CANCEL_OPTION,
                JOptionPane.PLAIN_MESSAGE);
        if (result != JOptionPane.OK_OPTION) return;
        if (id.getText().trim().isEmpty() || first.getText().trim().isEmpty() || last.getText().trim().isEmpty()) {
            message("Student ID, first name, and last name are required.");
            return;
        }
        if (existing == null && findStudent(id.getText().trim()) != null) {
            message("That Student ID already exists.");
            return;
        }

        if (existing == null) {
            Student s = new Student(id.getText().trim(), first.getText().trim(), last.getText().trim(),
                    (String) course.getSelectedItem(), (String) year.getSelectedItem(),
                    (String) gender.getSelectedItem(), birth.getText().trim(), email.getText().trim(),
                    contact.getText().trim(), address.getText().trim(), guardian.getText().trim(),
                    relationship.getText().trim(), guardianContact.getText().trim());
            students.add(s);
            clearances.add(new Student.ClearanceRecord(nextClearanceId(), s.getStudentID(), ADMIN_ID));
        } else {
            existing.setFirstName(first.getText().trim());
            existing.setLastName(last.getText().trim());
            existing.setCourse((String) course.getSelectedItem());
            existing.setYearLevel((String) year.getSelectedItem());
            existing.setGender((String) gender.getSelectedItem());
            existing.setBirthDate(birth.getText().trim());
            existing.setEmail(email.getText().trim());
            existing.setContact(contact.getText().trim());
            existing.setAddress(address.getText().trim());
            existing.setGuardian(guardian.getText().trim());
            existing.setRelationship(relationship.getText().trim());
            existing.setGuardianContact(guardianContact.getText().trim());
        }
        refreshAllTables();
    }

    private void editStudent() {
        int row = studentTable.getSelectedRow();
        if (row < 0) { message("Please select a student first."); return; }
        studentDialog(findStudent(String.valueOf(studentModel.getValueAt(row, 0))));
    }

    private void deleteStudent() {
        int row = studentTable.getSelectedRow();
        if (row < 0) { message("Please select a student first."); return; }
        String id = String.valueOf(studentModel.getValueAt(row, 0));
        int answer = JOptionPane.showConfirmDialog(this, "Delete student " + id + " and their linked records?",
                "Confirm Delete", JOptionPane.YES_NO_OPTION);
        if (answer == JOptionPane.YES_OPTION) {
            students.removeIf(s -> s.getStudentID().equals(id));
            clearances.removeIf(c -> c.getStudentID().equals(id));
            payments.removeIf(p -> p.getStudentID().equals(id));
            refreshAllTables();
        }
    }

    private void updateClearance() {
        int row = clearanceTable.getSelectedRow();
        if (row < 0) { message("Select a clearance record first."); return; }
        String id = String.valueOf(clearanceModel.getValueAt(row, 1));
        Student.ClearanceRecord c = findClearance(id);
        if (c == null) return;
        String[] offices = {"Registrar", "Library", "Accounting", "Clinic", "Guidance", "Student Affairs"};
        String office = (String) JOptionPane.showInputDialog(this, "Choose office:", "Update Clearance",
                JOptionPane.QUESTION_MESSAGE, null, offices, offices[0]);
        if (office == null) return;
        String[] states = {"Pending", "Cleared"};
        String state = (String) JOptionPane.showInputDialog(this, "Set " + office + " status:",
                "Office Status", JOptionPane.QUESTION_MESSAGE, null, states, states[0]);
        if (state == null) return;
        c.setStatus(office, state);
        refreshAllTables();
    }

    private void addPayment() {
        if (students.isEmpty()) { message("Add a student first."); return; }
        String[] options = new String[students.size()];
        for (int i = 0; i < students.size(); i++)
            options[i] = students.get(i).getStudentID() + " - " + students.get(i).getFullName();
        String chosen = (String) JOptionPane.showInputDialog(this, "Select student:", "New Payment",
                JOptionPane.QUESTION_MESSAGE, null, options, options[0]);
        if (chosen == null) return;
        String studentID = chosen.split(" - ")[0];

        JTextField description = new JTextField("School Fee");
        JTextField amount = new JTextField("0.00");
        JComboBox<String> status = new JComboBox<>(new String[]{"Pending", "Paid"});
        JPanel panel = new JPanel(new GridLayout(0, 2, 8, 8));
        panel.add(new JLabel("Description")); panel.add(description);
        panel.add(new JLabel("Amount (PHP)")); panel.add(amount);
        panel.add(new JLabel("Status")); panel.add(status);
        if (JOptionPane.showConfirmDialog(this, panel, "Payment Details",
                JOptionPane.OK_CANCEL_OPTION) != JOptionPane.OK_OPTION) return;

        try {
            double value = Double.parseDouble(amount.getText().trim());
            if (value < 0) throw new NumberFormatException();
            payments.add(new Student.PaymentRecord(nextReceiptNo(), studentID, ADMIN_ID,
                    description.getText().trim(), value, LocalDate.now().toString(),
                    (String) status.getSelectedItem()));
            refreshAllTables();
        } catch (NumberFormatException ex) {
            message("Please enter a valid amount (zero or greater).");
        }
    }

    private void changePaymentStatus() {
        int row = paymentTable.getSelectedRow();
        if (row < 0) { message("Select a payment record first."); return; }
        String receipt = String.valueOf(paymentModel.getValueAt(row, 0));
        for (Student.PaymentRecord p : payments) {
            if (p.getReceiptNo().equals(receipt)) {
                p.setStatus("Paid".equals(p.getStatus()) ? "Pending" : "Paid");
                break;
            }
        }
        refreshAllTables();
    }

    private void addAnnouncement() {
        JTextField title = new JTextField();
        JTextArea message = new JTextArea(5, 25);
        message.setLineWrap(true);
        message.setWrapStyleWord(true);
        JPanel panel = new JPanel(new BorderLayout(0, 8));
        JPanel top = new JPanel(new BorderLayout(0, 4));
        top.add(new JLabel("Announcement Title"), BorderLayout.NORTH);
        top.add(title, BorderLayout.CENTER);
        panel.add(top, BorderLayout.NORTH);
        panel.add(new JScrollPane(message), BorderLayout.CENTER);
        if (JOptionPane.showConfirmDialog(this, panel, "New Announcement",
                JOptionPane.OK_CANCEL_OPTION) != JOptionPane.OK_OPTION) return;
        if (title.getText().trim().isEmpty() || message.getText().trim().isEmpty()) {
            message("Please enter both a title and a message.");
            return;
        }
        announcements.add(new Student.AnnouncementRecord(nextAnnouncementId(), ADMIN_ID,
                title.getText().trim(), message.getText().trim(), LocalDate.now().toString()));
        refreshAllTables();
    }

    private void message(String text) {
        JOptionPane.showMessageDialog(this, text, "Clearance Tracking Portal", JOptionPane.INFORMATION_MESSAGE);
    }
}
