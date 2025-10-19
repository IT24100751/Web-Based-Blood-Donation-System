package com.example.blooddonatesystem.features.admin_management;

public class AdminDTOS {

    // DTO for retrieving admin data
    public static class GetAdminDTO {
        private Long id;
        private String adminId;
        private String firstName;
        private String lastName;
        private String email;

        public GetAdminDTO() {
        }

        public GetAdminDTO(Long id, String adminId, String firstName, String lastName, String email) {
            this.id = id;
            this.adminId = adminId;
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
        }

        // Static method to convert from model to DTO
        public static GetAdminDTO fromModel(AdminModel model) {
            return new GetAdminDTO(
                    model.getId(),
                    model.getAdminId(),
                    model.getFirstName(),
                    model.getLastName(),
                    model.getEmail()
            );
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getAdminId() {
            return adminId;
        }

        public void setAdminId(String adminId) {
            this.adminId = adminId;
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
    }

    // DTO for creating new admin
    public static class CreateAdminDTO {
        private String firstName;
        private String lastName;
        private String email;
        private String password;

        public CreateAdminDTO() {
        }

        public CreateAdminDTO(String firstName, String lastName, String email, String password) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.password = password;
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
    }

    // DTO for updating admin
    public static class UpdateAdminDTO {
        private String firstName;
        private String lastName;
        private String email;

        public UpdateAdminDTO() {
        }

        public UpdateAdminDTO(String firstName, String lastName, String email) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
        }

        // Apply updates to an existing model
        public void applyToModel(AdminModel model) {
            if (this.firstName != null) {
                model.setFirstName(this.firstName);
            }
            if (this.lastName != null) {
                model.setLastName(this.lastName);
            }
            if (this.email != null) {
                model.setEmail(this.email);
            }
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
    }

    // DTO for admin login
    public static class LoginAdminDTO {
        private String email;
        private String password;

        public LoginAdminDTO() {
        }

        public LoginAdminDTO(String email, String password) {
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