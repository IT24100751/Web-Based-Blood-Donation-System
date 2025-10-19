package com.example.blooddonatesystem.features.donor_management;

public class DonorDTOS {

    // DTO for retrieving donor information
    public static class GetDonorDTO {
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private String bloodType;
        private String gender;
        private String contactNumber;

        public GetDonorDTO() {
        }

        public GetDonorDTO(Long id, String firstName, String lastName, String email, 
                          String bloodType, String gender, String contactNumber) {
            this.id = id;
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.bloodType = bloodType;
            this.gender = gender;
            this.contactNumber = contactNumber;
        }

        // Factory method to create DTO from entity
        public static GetDonorDTO fromEntity(DonorModel donor) {
            return new GetDonorDTO(
                donor.getId(),
                donor.getFirstName(),
                donor.getLastName(),
                donor.getEmail(),
                donor.getBloodType(),
                donor.getGender(),
                donor.getContactNumber()
            );
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }
    }

    // DTO for creating a new donor
    public static class CreateDonorDTO {
        private String firstName;
        private String lastName;
        private String email;
        private String password;
        private String bloodType;
        private String gender;
        private String contactNumber;

        public CreateDonorDTO() {
        }

        public CreateDonorDTO(String firstName, String lastName, String email, String password,
                             String bloodType, String gender, String contactNumber) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.password = password;
            this.bloodType = bloodType;
            this.gender = gender;
            this.contactNumber = contactNumber;
        }

        // Convert DTO to entity
        public DonorModel toEntity() {
            DonorModel donor = new DonorModel();
            donor.setFirstName(firstName);
            donor.setLastName(lastName);
            donor.setEmail(email);
            donor.setPassword(password); // Note: Password should be hashed in service layer
            donor.setBloodType(bloodType);
            donor.setGender(gender);
            donor.setContactNumber(contactNumber);
            donor.setDeleteStatus(false);
            return donor;
        }

        // Getters and Setters
        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }
    }

    // DTO for updating an existing donor
    public static class UpdateDonorDTO {
        private String firstName;
        private String lastName;
        private String email;
        private String bloodType;
        private String gender;
        private String contactNumber;

        public UpdateDonorDTO() {
        }

        public UpdateDonorDTO(String firstName, String lastName, String email,
                             String bloodType, String gender, String contactNumber) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.bloodType = bloodType;
            this.gender = gender;
            this.contactNumber = contactNumber;
        }

        // Update entity from DTO
        public void updateEntity(DonorModel donor) {
            if (firstName != null) donor.setFirstName(firstName);
            if (lastName != null) donor.setLastName(lastName);
            if (email != null) donor.setEmail(email);
            if (bloodType != null) donor.setBloodType(bloodType);
            if (gender != null) donor.setGender(gender);
            if (contactNumber != null) donor.setContactNumber(contactNumber);
        }

        // Getters and Setters
        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }
    }

    // DTO for donor login
    public static class LoginDonorDTO {
        private String email;
        private String password;

        public LoginDonorDTO() {
        }

        public LoginDonorDTO(String email, String password) {
            this.email = email;
            this.password = password;
        }

        // Getters and Setters
        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }
}