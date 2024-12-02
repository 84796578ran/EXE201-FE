import 'package:flutter/material.dart';
import '../../../Models/post.dart';
import '../../../Models/user.dart';
import '../../../repositories/order_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../../repositories/post_repository.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  final Post post;

  const OrderDetailScreen({
    super.key,
    required this.order,
    required this.post,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final UserRepository _userRepository = UserRepository.instance;
  bool _isLoading = true;
  User? _provider;

  @override
  void initState() {
    super.initState();
    _loadProviderInfo();
  }

  Future<void> _loadProviderInfo() async {
    try {
      final provider = await _userRepository.getUser(widget.post.providerId);
      setState(() {
        _provider = provider;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading provider info: ${e.toString()}')),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Đang chờ duyệt';
      case 'accepted':
        return 'Đã chấp nhận';
      case 'canceled':
        return 'Đã từ chối';
      default:
        return 'Không xác định';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn đặt phòng'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Status
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getStatusColor(widget.order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(widget.order.status),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: _getStatusColor(widget.order.status),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getStatusText(widget.order.status),
                          style: TextStyle(
                            color: _getStatusColor(widget.order.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Provider Info
                  const Text(
                    'Thông tin chủ trọ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(_provider?.avatar != null
                            ? Icons.person
                            : Icons.person_outline),
                      ),
                      title: Text(_provider?.fullName ?? 'N/A'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_provider?.email ?? 'N/A'),
                          Text(_provider?.phone ?? 'N/A'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Room Info
                  const Text(
                    'Thông tin phòng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        if (widget.post.images.isNotEmpty)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.memory(
                              widget.post.images[0].url,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(widget.post.address),
                              const SizedBox(height: 8),
                              Text(
                                'Giá: ${widget.post.price.toStringAsFixed(0)}đ/tháng',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Booking Details
                  const Text(
                    'Chi tiết đặt phòng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Ngày nhận phòng'),
                            subtitle: Text(widget.order.checkIn),
                          ),
                          ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Ngày trả phòng'),
                            subtitle: Text(widget.order.checkOut),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
} 