package Portal;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;


public class Main {
// CONSTANT: sets the maximum number of allowed login attempts.
    private static final int MAX_LOGIN_ATTEMPTS = 3;
// STATIC CLASS VARIABLE: counts failed login attempts across the login screen.
    private static int loginAttempts = 0;
// ENCAPSULATION: private static field stores the current admin password for this demo.
    private static String adminPassword = "Borlasa123";
    
// METHOD: checks the current password and updates it when it matches.
    public static boolean changeAdminPassword(String currentPassword, String newPassword){
        if(!adminPassword.equals(currentPassword)) return false;
        adminPassword = newPassword;
        return true;
    }
    private static final Color NAVY = new Color(35, 63, 112);
    private static final Color BLUE = new Color(8, 76, 166);
    private static final Color TEXT = Color.BLACK;

// MAIN METHOD: entry point of the Java application.
    public static void main(String[] args) {
// EVENT DISPATCH THREAD: starts Swing UI work on the appropriate GUI thread.
        SwingUtilities.invokeLater(() -> {
            try {
                UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            } catch (Exception ignored) { }
            setReadableDefaults();
            showLogin();
        });
    }

// HELPER METHOD: sets default text colors for common Swing components.
    private static void setReadableDefaults() {
        UIManager.put("Label.foreground", Color.BLACK);
        UIManager.put("Button.foreground", Color.BLACK);
        UIManager.put("TextField.foreground", Color.BLACK);
        UIManager.put("PasswordField.foreground", Color.BLACK);
        UIManager.put("OptionPane.messageForeground", Color.BLACK);
    }

// GUI METHOD: builds and displays the login window.
    private static void showLogin() {
        JFrame frame = new JFrame("San Isidro College - Login");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(650, 520);
        frame.setMinimumSize(new Dimension(600, 480));
        frame.setLocationRelativeTo(null);

        JPanel background = new JPanel(new GridBagLayout());
        background.setBackground(new Color(245, 247, 250));
        background.setBorder(new EmptyBorder(24, 24, 24, 24));

        JPanel card = new JPanel(new GridBagLayout());
        card.setBackground(Color.WHITE);
        card.setPreferredSize(new Dimension(470, 390));
        card.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(215, 222, 232)),
                new EmptyBorder(28, 38, 28, 38)));

        GridBagConstraints c = new GridBagConstraints();
        c.gridx = 0;
        c.gridwidth = 1;
        c.weightx = 1;
        c.fill = GridBagConstraints.HORIZONTAL;
        c.anchor = GridBagConstraints.CENTER;
        c.insets = new Insets(7, 0, 7, 0);

        JLabel schoolName = new JLabel("SAN ISIDRO COLLEGE", SwingConstants.CENTER);
        schoolName.setFont(new Font("SansSerif", Font.BOLD, 25));
        schoolName.setForeground(NAVY);
        c.gridy = 0;
        c.insets = new Insets(0, 0, 5, 0);
        card.add(schoolName, c);

        JLabel heading = new JLabel("Clearance Tracking Portal Login", SwingConstants.CENTER);
        heading.setFont(new Font("SansSerif", Font.BOLD, 19));
        heading.setForeground(TEXT);
        c.gridy++;
        c.insets = new Insets(0, 0, 4, 0);
        card.add(heading, c);

        JLabel subtitle = new JLabel("Please log in to continue", SwingConstants.CENTER);
        subtitle.setFont(new Font("SansSerif", Font.PLAIN, 14));
        subtitle.setForeground(new Color(80, 80, 80));
        c.gridy++;
        c.insets = new Insets(0, 0, 22, 0);
        card.add(subtitle, c);

        JLabel userLabel = new JLabel("Username");
        userLabel.setFont(new Font("SansSerif", Font.BOLD, 13));
        userLabel.setForeground(TEXT);
        c.gridy++;
        c.insets = new Insets(0, 0, 6, 0);
        card.add(userLabel, c);

        JTextField username = new JTextField();
        styleField(username);
        username.setPreferredSize(new Dimension(380, 42));
        c.gridy++;
        c.insets = new Insets(0, 0, 15, 0);
        card.add(username, c);

        JLabel passLabel = new JLabel("Password");
        passLabel.setFont(new Font("SansSerif", Font.BOLD, 13));
        passLabel.setForeground(TEXT);
        c.gridy++;
        c.insets = new Insets(0, 0, 6, 0);
        card.add(passLabel, c);

        JPasswordField password = new JPasswordField();
        styleField(password);
        password.setPreferredSize(new Dimension(380, 42));
        c.gridy++;
        c.insets = new Insets(0, 0, 20, 0);
        card.add(password, c);

        JButton login = new JButton("LOG IN");
        login.setFont(new Font("SansSerif", Font.BOLD, 15));
        login.setForeground(Color.WHITE);
        login.setBackground(BLUE);
        login.setOpaque(true);
        login.setBorderPainted(false);
        login.setFocusPainted(false);
        login.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        login.setPreferredSize(new Dimension(380, 43));
        c.gridy++;
        c.insets = new Insets(0, 0, 0, 0);
        card.add(login, c);

// LAMBDA EXPRESSION: defines the login validation process for both button and Enter key.
        Runnable authenticate = () -> {
            String user = username.getText().trim();
            String pass = new String(password.getPassword());
            
// CONDITIONAL: checks the username and password before opening the portal.
            if ("Ericka".equals(user) && adminPassword.equals(pass)) {
                frame.dispose();
                new SchoolPortal();
            } else {
// COUNTER UPDATE: increases the failed-attempt count after an incorrect login.
                loginAttempts++;
                int remaining = MAX_LOGIN_ATTEMPTS-loginAttempts;
                if (remaining>0){
                JOptionPane.showMessageDialog(frame,
                        "Incorrect username or password. Attempts remaining." + remaining,
                        "Login Failed", JOptionPane.ERROR_MESSAGE);
                password.setText("");
                password.requestFocusInWindow();
            }else{
                    JOptionPane.showMessageDialog(frame,
                            "You have used all 3 login attempts. The system will now close.",
                            "Login Locked", JOptionPane.ERROR_MESSAGE);
                    frame.dispose();
                    System.exit(0);
                }
            }
        };
// EVENT HANDLING: runs the login validation when the Login button is clicked.
        login.addActionListener(e -> authenticate.run());
        password.addActionListener(e -> authenticate.run());

        background.add(card);
        frame.setContentPane(background);
        frame.getRootPane().setDefaultButton(login);
        frame.setVisible(true);
        username.requestFocusInWindow();
    }

// REUSABLE HELPER METHOD: applies consistent formatting to a text field.
    private static void styleField(JTextField field) {
        field.setFont(new Font("SansSerif", Font.PLAIN, 15));
        field.setForeground(TEXT);
        field.setBackground(Color.WHITE);
        field.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(185, 195, 210)),
                new EmptyBorder(8, 10, 8, 10)));
    }
}
