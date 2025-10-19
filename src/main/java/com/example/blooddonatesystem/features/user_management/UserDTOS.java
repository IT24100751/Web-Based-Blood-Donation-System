package com.example.blooddonatesystem.features.user_management;

import java.io.Serializable;

/**
 * This class contains all DTOs related to User operations
 */
public class UserDTOS {

    /**
     * DTO for retrieving user information
     */
    public static class GetUserDTO implements Serializable {
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private String contactNumber;
        private String role;
        private String gender;
        private Integer age;

        // Default constructor
        public GetUserDTO() {
        }

        // Constructor with UserModel
        public GetUserDTO(UserModel userModel) {
            this.id = userModel.getId();
            this.firstName = userModel.getFirstName();
            this.lastName = userModel.getLastName();
            this.email = userModel.getEmail();
            this.contactNumber = userModel.getContactNumber();
            this.role = userModel.getRole();
            this.gender = userModel.getGender();
            this.age = userModel.getAge();
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

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public Integer getAge() {
            return age;
        }

        public void setAge(Integer age) {
            this.age = age;
        }
    }

    /**
     * DTO for creating a new user
     */
    public static class CreateUserDTO implements Serializable {
        private String firstName;
        private String lastName;
        private String email;
        private String password;
        private String contactNumber;
        private String role;
        private String gender;
        private Integer age;

        // Default constructor
        public CreateUserDTO() {
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

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public Integer getAge() {
            return age;
        }

        public void setAge(Integer age) {
            this.age = age;
        }

        // Convert to UserModel
        public UserModel toUserModel() {
            UserModel userModel = new UserModel();
            userModel.setFirstName(this.firstName);
            userModel.setLastName(this.lastName);
            userModel.setEmail(this.email);
            userModel.setPassword(this.password);
            userModel.setContactNumber(this.contactNumber);
            userModel.setRole(this.role);
            userModel.setGender(this.gender);
            userModel.setAge(this.age);
            userModel.setDeleteStatus(false);
            return userModel;
        }
    }

    /**
     * DTO for updating an existing user
     */
    public static class UpdateUserDTO implements Serializable {
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private String contactNumber;
        private String role;
        private String gender;
        private Integer age;

        // Default constructor
        public UpdateUserDTO() {
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

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public Integer getAge() {
            return age;
        }

        public void setAge(Integer age) {
            this.age = age;
        }

        // Update UserModel
        public void updateUserModel(UserModel userModel) {
            if (this.firstName != null) userModel.setFirstName(this.firstName);
            if (this.lastName != null) userModel.setLastName(this.lastName);
            if (this.email != null) userModel.setEmail(this.email);
            if (this.contactNumber != null) userModel.setContactNumber(this.contactNumber);
            if (this.role != null) userModel.setRole(this.role);
            if (this.gender != null) userModel.setGender(this.gender);
            if (this.age != null) userModel.setAge(this.age);
        }
    }

    /**
     * DTO for user login
     */
    public static class LoginUserDTO implements Serializable {
        private String email;
        private String password;

        // Default constructor
        public LoginUserDTO() {
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