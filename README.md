# 🗒️ Note App - Flutter Provider State Management

**Sinh viên:** Trần Thị Mỹ Linh - 22IT155

Dự án này là một ứng dụng ghi chú hiện đại và có khả năng phản hồi (responsive), được xây dựng để minh họa việc quản lý trạng thái toàn ứng dụng (app-wide state) một cách hiệu quả bằng thư viện **Provider**.

## 🌟 Tổng quan Dự án & Tính năng nổi bật

| Tính năng | Mô tả | Trạng thái |
| :--- | :--- | :--- |
| **CRUD Operations** | Tạo, Đọc, Cập nhật, Xóa ghi chú theo thời gian thực. | ✅ Hoàn thành |
| **State Management** | Quản lý trạng thái bằng **Provider** và **ChangeNotifier**. | ✅ Hoàn thành |
| **Responsive Grid** | Layout Grid động, tự động thích ứng với kích thước màn hình (2 cột). | ✅ Hoàn thành |
| **Smart Search** | Tính năng tìm kiếm ghi chú theo tiêu đề hoặc nội dung theo thời gian thực. | ✅ Hoàn thành |
| **Color Picker** | Cho phép người dùng chọn màu nền tùy chỉnh cho từng ghi chú. | ✅ Hoàn thành |
| **Time Display** | Hiển thị thời gian tạo/cập nhật dưới dạng tương đối (ví dụ: '2 giờ trước'). | ✅ Hoàn thành |
| **Safe Delete** | Yêu cầu xác nhận (Confirmation Dialog) trước khi xóa ghi chú. | ✅ Hoàn thành |
| **UI/UX Features** | Thiết kế theo Material Design 3, sử dụng `Dismissible` và `Empty States`. | ✅ Hoàn thành |

## ⚙️ Technical Stack & Dependencies

* **Framework:** Flutter 3.19+
* **Language:** Dart 2.19+
* **State Management:** Provider 6.0+

| Dependency | Phiên bản | Mục đích |
| :--- | :--- | :--- |
| `provider` | `^6.0.5` | Quản lý trạng thái ứng dụng toàn cục. |
| `intl` | `^0.18.1` | Hỗ trợ định dạng thời gian và quốc tế hóa (I18N). |
| `uuid` | `^4.2.1` | Đảm bảo mỗi ghi chú có một ID duy nhất (`id`). |

## 🚀 Installation & Setup

### Prerequisites

* Flutter SDK 3.19.0 hoặc cao hơn.
* Dart SDK 2.19.0 hoặc cao hơn.
* Android Studio/VSCode với Flutter extension.

### Steps to Run

1.  **Clone Repository (Nếu có):**
    ```bash
    git clone [https://github.com/](https://github.com/)
    cd note_app
    ```
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the Application:**
    ```bash
    flutter run
    ```

## 📸 Screenshots

    lib/asset
