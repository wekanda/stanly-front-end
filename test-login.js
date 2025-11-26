const axios = require('axios');

const API_BASE = 'http://localhost:5000/api';

async function testLogin(email, password, role) {
  try {
    console.log(`\n🧪 Testing ${role} login: ${email}`);

    const response = await axios.post(`${API_BASE}/auth/login`, {
      email,
      password
    });

    if (response.data.success) {
      console.log(`✅ ${role} login successful!`);
      console.log(`   Token: ${response.data.token.substring(0, 50)}...`);
      console.log(`   User: ${response.data.user.name} (${response.data.user.role})`);

      // Test protected route
      const token = response.data.token;
      const protectedResponse = await axios.get(`${API_BASE}/auth/me`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      if (protectedResponse.data.success) {
        console.log(`✅ Protected route access successful for ${role}`);
      }

      return { success: true, token, user: response.data.user };
    } else {
      console.log(`❌ ${role} login failed: ${response.data.message}`);
      return { success: false };
    }
  } catch (error) {
    console.log(`❌ ${role} login error:`, error.response?.data?.message || error.message);
    return { success: false };
  }
}

async function testProjectSubmission(token, user) {
  try {
    console.log(`\n📝 Testing project submission for ${user.role}: ${user.name}`);

    const projectData = {
      title: `Test Project by ${user.name}`,
      description: 'This is a test project submission to verify the system works correctly.',
      category: 'Web Development',
      faculty: user.faculty,
      department: user.department,
      year: 2024,
      technologies: 'React, Node.js, MongoDB'
    };

    const response = await axios.post(`${API_BASE}/projects`, projectData, {
      headers: { Authorization: `Bearer ${token}` }
    });

    if (response.data.success) {
      console.log(`✅ Project submission successful!`);
      console.log(`   Project ID: ${response.data.data._id}`);
      console.log(`   Status: ${response.data.data.status}`);
      return response.data.data;
    } else {
      console.log(`❌ Project submission failed: ${response.data.message}`);
      return null;
    }
  } catch (error) {
    console.log(`❌ Project submission error:`, error.response?.data?.message || error.message);
    return null;
  }
}

async function testSupervisorApproval(token, projectId) {
  try {
    console.log(`\n👨‍🏫 Testing supervisor approval for project ${projectId}`);

    const response = await axios.put(`${API_BASE}/projects/${projectId}/approve`, {
      status: 'approved',
      comment: 'Excellent project! Approved for public display.'
    }, {
      headers: { Authorization: `Bearer ${token}` }
    });

    if (response.data.success) {
      console.log(`✅ Project approval successful!`);
      console.log(`   Status: ${response.data.data.status}`);
      return true;
    } else {
      console.log(`❌ Project approval failed: ${response.data.message}`);
      return false;
    }
  } catch (error) {
    console.log(`❌ Project approval error:`, error.response?.data?.message || error.message);
    return false;
  }
}

async function runTests() {
  console.log('🚀 Starting UCU Innovators Hub API Tests\n');

  // Test all user logins
  const studentResult = await testLogin('student@mbalehub.com', 'password123', 'Student');
  const supervisorResult = await testLogin('supervisor@mbalehub.com', 'password123', 'Supervisor');
  const adminResult = await testLogin('admin@mbalehub.com', 'password123', 'Admin');

  // Test project submission
  if (studentResult.success) {
    const project = await testProjectSubmission(studentResult.token, studentResult.user);

    // Test supervisor approval
    if (project && supervisorResult.success) {
      await testSupervisorApproval(supervisorResult.token, project._id);
    }
  }

  console.log('\n🎯 Test Summary:');
  console.log(`   Student Login: ${studentResult.success ? '✅' : '❌'}`);
  console.log(`   Supervisor Login: ${supervisorResult.success ? '✅' : '❌'}`);
  console.log(`   Admin Login: ${adminResult.success ? '✅' : '❌'}`);
  console.log(`   Project Submission: ${studentResult.success ? '✅' : '❌'}`);
  console.log(`   Supervisor Approval: ${supervisorResult.success && studentResult.success ? '✅' : '❌'}`);

  console.log('\n🏆 ALL TESTS COMPLETED!');
}

runTests().catch(console.error);