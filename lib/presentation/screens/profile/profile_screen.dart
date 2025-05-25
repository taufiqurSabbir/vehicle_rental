import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental/data/models/user_model.dart';
import '../../../data/models/auth_utility.dart';
import '../../controllers/auth_controller.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;
  bool isLoading = false;

  // Mock trips count
  int totalTrips = 0;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() => isLoading = true);

    try {
      // Use AuthController to refresh and get latest user info
      final authController = Get.put(AuthController());
      final UserModel? updatedUser = await authController.UserData();

      if (updatedUser != null) {
        totalTrips = updatedUser.totalTrip ?? 0;
        setState(() {
          userModel = updatedUser;
        });
      }
    } catch (e) {
      print("Error refreshing user: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = userModel?.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? Center(child: Text('No user data available', style: TextStyle(fontSize: 18.sp)))
          : RefreshIndicator(
        onRefresh: _loadUser,
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            _buildProfileCard(user),
            const SizedBox(height: 20),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(User user) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.deepPurple,
            child: Text(
              user.name?.isNotEmpty == true ? user.name![0].toUpperCase() : '?',
              style: TextStyle(fontSize: 28.sp, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            user.name ?? 'Unknown',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? userModel?.email ?? '',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoTile(
          icon: Icons.directions_car,
          label: 'Total Trips',
          value: '$totalTrips',
        ),
        const SizedBox(height: 12),
        _infoTile(
          icon: Icons.verified_user,
          label: 'Account Status',
          value: 'Active',
        ),
        const SizedBox(height: 12),
        _infoTile(
          icon: Icons.support_agent,
          label: 'Support',
          value: 'Help & Feedback',
        ),
      ],
    );
  }

  Widget _infoTile({required IconData icon, required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
