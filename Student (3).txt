package Portal;
import java.util.ArrayList;

public class Student extends Person {
    private String studentID;
    private String course;
    private String yearLevel;
    private String gender;
    private String birthDate;
    private String guardian;
    private String relationship;
    private String guardianContact;

    public Student(String studentID, String firstName, String lastName,
    String course, String yearLevel, String gender,
    String birthDate, String email, String contact, String address,
    String guardian, String relationship, String guardianContact) {
        super(firstName, lastName, email, contact, address);
        this.studentID = studentID;
        this.course = course;
        this.yearLevel = yearLevel;
        this.gender = gender;
        this.birthDate = birthDate;
        this.guardian = guardian;
        this.relationship = relationship;
        this.guardianContact = guardianContact;
    }

    public String getStudentID() { return studentID; }
    public String getCourse() { return course; }
    public String getYearLevel() { return yearLevel; }
    public String getGender() { return gender; }
    public String getBirthDate() { return birthDate; }
    public String getGuardian() { return guardian; }
    public String getRelationship() { return relationship; }
    public String getGuardianContact() { return guardianContact; }

    public void setStudentID(String studentID) { this.studentID = studentID; }
    public void setCourse(String course) { this.course = course; }
    public void setYearLevel(String yearLevel) { this.yearLevel = yearLevel; }
    public void setGender(String gender) { this.gender = gender; }
    public void setBirthDate(String birthDate) { this.birthDate = birthDate; }
    public void setGuardian(String guardian) { this.guardian = guardian; }
    public void setRelationship(String relationship) { this.relationship = relationship; }
    public void setGuardianContact(String guardianContact) { this.guardianContact = guardianContact; }

    @Override
    public String getPersonType() {
        return "Student";
    }

    public static class ClearanceRecord {
        private String clearanceID;
        private String studentID;
        private String registrarStatus, libraryStatus, accountingStatus;
        private String clinicStatus, guidanceStatus, studentAffairsStatus;
        private String overallStatus;

        public ClearanceRecord(String clearanceID, String studentID) {
            this.clearanceID = clearanceID;
            this.studentID = studentID;
            registrarStatus = libraryStatus = accountingStatus = "Pending";
            clinicStatus = guidanceStatus = studentAffairsStatus = "Pending";
            updateOverallStatus();
        }

        public String getClearanceID() { return clearanceID; }
        public String getStudentID() { return studentID; }
        public String getRegistrarStatus() { return registrarStatus; }
        public String getLibraryStatus() { return libraryStatus; }
        public String getAccountingStatus() { return accountingStatus; }
        public String getClinicStatus() { return clinicStatus; }
        public String getGuidanceStatus() { return guidanceStatus; }
        public String getStudentAffairsStatus() { return studentAffairsStatus; }
        public String getOverallStatus() { return overallStatus; }

        public void setStatus(String office, String status) {
            switch (office) {
                case "Registrar": registrarStatus = status; break;
                case "Library": libraryStatus = status; break;
                case "Accounting": accountingStatus = status; break;
                case "Clinic": clinicStatus = status; break;
                case "Guidance": guidanceStatus = status; break;
                case "Student Affairs": studentAffairsStatus = status; break;
                default: break;
            }
            updateOverallStatus();
        }

        public int getProgress() {
            int complete = 0;
            String[] statuses = {registrarStatus, libraryStatus, accountingStatus,
                clinicStatus, guidanceStatus, studentAffairsStatus};
            for (String status : statuses) {
                if ("Cleared".equals(status)) complete++;
            }
            return (complete * 100) / statuses.length;
        }

        private void updateOverallStatus() {
            overallStatus = getProgress() == 100 ? "Cleared" : "Pending";
        }
    }

    public static class PaymentRecord {
        private String receiptNo;
        private String studentID;
        private String description;
        private double amount;
        private String date;
        private String status;

        public PaymentRecord(String receiptNo, String studentID, String description,
        double amount, String date, String status) {
            this.receiptNo = receiptNo;
            this.studentID = studentID;
            this.description = description;
            this.amount = amount;
            this.date = date;
            this.status = status;
        }
        public String getReceiptNo() { return receiptNo; }
        public String getStudentID() { return studentID; }
        public String getDescription() { return description; }
        public double getAmount() { return amount; }
        public String getDate() { return date; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }

    public static class AnnouncementRecord {
        private String announcementID;
        private String title;
        private String message;
        private String date;

        public AnnouncementRecord(String announcementID, String title, String message, String date) {
            this.announcementID = announcementID;
            this.title = title;
            this.message = message;
            this.date = date;
        }
        public String getAnnouncementID() { return announcementID; }
        public String getTitle() { return title; }
        public String getMessage() { return message; }
        public String getDate() { return date; }
    }
} 