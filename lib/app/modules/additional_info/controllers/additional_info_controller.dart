import 'package:get/get.dart';

class AdditionalInfoController extends GetxController {
  var htmlContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // loadHtmlContent();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String loadHtmlContent(String title) {
    switch(title){
      case 'About BCS':
        return '''
<body>
<div style='font-family: bn,fredoka'>
    <h1>বিসিএস পরীক্ষা সম্পর্কে সংক্ষিপ্ত বিবরণ</h1>
    
    <h2>বিসিএস পরীক্ষার ধাপসমূহ:</h2>
    <ul style="text-align:justify">
        <li><strong>প্রিলিমিনারি পরীক্ষা (২০০ নম্বরের MCQ টেস্ট):</strong> বাংলা, ইংরেজি, সাধারণ জ্ঞান, বিজ্ঞান, গণিত ও মানসিক দক্ষতা,ভূগোল,কম্পিউটার ও তথ্য প্রযুক্তি,     
নৈতিকতা, মূল্যবোধ ও সু-শাসন বিষয়ক প্রশ্ন থাকে।</li>
        <li><strong>লিখিত পরীক্ষা (৯০০ নম্বর):</strong> প্রিলিমিনারি উত্তীর্ণদের জন্য বিস্তারিত লিখিত পরীক্ষা অনুষ্ঠিত হয়।</li>
        <li><strong>মৌখিক পরীক্ষা (১০০ নম্বর):</strong> লিখিত পরীক্ষায় উত্তীর্ণদের জন্য ব্যক্তিত্ব ও জ্ঞান মূল্যায়নের মৌখিক পরীক্ষা নেওয়া হয়।</li>
    </ul>

    <h2>বয়স ও যোগ্যতা:</h2>
    <ul style="text-align:justify">
        <li>সাধারণত ২১-৩২ বছর বয়সীরা আবেদন করতে পারেন।</li>
        <li>ন্যূনতম শিক্ষাগত যোগ্যতা স্নাতক বা সমমান।</li>
    </ul>

    <h2>বিসিএস ক্যাডারসমূহ:</h2>
    <p>বিসিএস ক্যাডার দুইটি ভাগে বিভক্ত:</p>
    <ul style="text-align:justify">
        <li>সাধারণ ক্যাডার (প্রশাসন, পুলিশ, কাস্টমস, পররাষ্ট্র ইত্যাদি)।</li>
        <li>কারিগরি/পেশাগত ক্যাডার (স্বাস্থ্য, প্রকৌশল, শিক্ষা, কৃষি ইত্যাদি)।</li>
    </ul>

    <h2>প্রিলিমিনারি পরীক্ষার বিষয় ও নম্বর বণ্টন:</h2>
    <ul style="text-align:justify">
        <li>বাংলা ভাষা ও সাহিত্য – ৩৫</li>
        <li>ইংরেজি ভাষা ও সাহিত্য – ৩৫</li>
        <li>বাংলাদেশ বিষয়াবলি – ৩০</li>
        <li>আন্তর্জাতিক বিষয়াবলি – ২০</li>
        <li>ভূগোল (বাংলাদেশ ও বিশ্ব), পরিবেশ ও দুর্যোগ ব্যবস্থাপনা - ১০</li>
        <li>সাধারণ বিজ্ঞান - ১৫</li>
        <li>কম্পিউটার ও তথ্য প্রযুক্তি – ১৫</li>
        <li>গাণিতিক যুক্তি – ১৫</li>
        <li>মানসিক দক্ষতা – ১৫</li>
        <li>নৈতিকতা, মূল্যবোধ ও সুশাসন – ১০</li>
        <li><strong>মোট – ২০০</strong></li>
    </ul>

    <h2>লিখিত পরীক্ষার বিষয় ও নম্বর বণ্টন:</h2>
    <p><strong>সাধারণ ক্যাডারের জন্য:</strong></p>
    <ul style="text-align:justify">
        <li>বাংলা – ২০০</li>
        <li>ইংরেজি – ২০০</li>
        <li>বাংলাদেশ বিষয়াবলি – ২০০</li>
        <li>আন্তর্জাতিক বিষয়াবলি – ১০০</li>
        <li>গণিত ও মানসিক দক্ষতা – ১০০</li>
        <li>বিজ্ঞান ও প্রযুক্তি – ১০০</li>
        <li><strong>মোট – ৯০০</strong></li>
    </ul>

    <p><strong>কারিগরি ক্যাডারের জন্য:</strong></p>
    <ul style="text-align:justify">
        <li>বাংলা – ১০০</li>
        <li>ইংরেজি – ২০০</li>
        <li>বাংলাদেশ বিষয়াবলি – ২০০</li>
        <li>আন্তর্জাতিক বিষয়াবলি – ১০০</li>
        <li>গণিত ও মানসিক দক্ষতা – ১০০</li>
        <li>পদ সংশ্লিষ্ট বিষয় – ২০০</li>
        <li><strong>মোট – ৯০০</strong></li>
    </ul>

    <h2>মৌখিক পরীক্ষা (ভাইভা):</h2>
    <p>১০০ নম্বরের মৌখিক পরীক্ষা, যেখানে কমপক্ষে ৫০% নম্বর পেতে হবে।</p>

    <h2>বিসিএস প্রস্তুতির জন্য টিপস:</h2>
    <ul style="text-align:justify">
        <li>বিগত বছরের প্রশ্নপত্র অনুশীলন করুন।</li>
        <li>নির্ভরযোগ্য বই ও সাম্প্রতিক ঘটনাবলী সম্পর্কে আপডেট থাকুন।</li>
        <li>ভালোভাবে সময় ব্যবস্থাপনা করুন এবং নিয়মিত মডেল টেস্ট দিন।</li>
    </ul>

    <h2>উপসংহার:</h2>
    <p>বিসিএস পরীক্ষা অত্যন্ত প্রতিযোগিতামূলক। সঠিক পরিকল্পনা, অধ্যবসায় ও কৌশলের মাধ্যমে কাঙ্ক্ষিত ক্যাডারে যোগদান করা সম্ভব।</p>
</div>

</body>
''';
      case 'Privacy Policy':
        return '''
<body>
    <h2 class = "justify">Introduction</h2>
    <p class = "justify">Welcome to <strong>BCS Question & Exam</strong>. We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, store, and protect your data when you use our app. By using our services, you agree to this Privacy Policy.</p>

    <h2 class = "justify">1. Information We Collect</h2>
    <p class = "justify">When you use our platform, we collect the following types of information:</p>

    <h3 class = "justify">1.1 User-Provided Information</h3>
    <ul class = "justify">
        <li><strong>Account Information:</strong> Name, email address, and password during registration.</li>
        <li><strong>Profile Information:</strong> Profile image, university/college name, address, and mobile number.</li>
        <li><strong>Contact Requests:</strong> Information submitted via our contact or data deletion request forms.</li>
    </ul>

    <h3 class = "justify">1.2 Automatically Collected Information</h3>
    <ul class = "justify">
        <li><strong>Usage Data:</strong> Information about device type, IP address, browser type, and activity logs.</li>
        <li><strong>Cookies & Tracking:</strong> We may use cookies and analytics tools to improve user experience.</li>
    </ul>

    <h2 class = "justify">2. How We Use Your Information</h2>
    <ul class = "justify">
        <li>To create and manage user accounts.</li>
        <li>To improve app performance, features, and user experience.</li>
        <li>To provide personalized content and recommendations.</li>
        <li>To respond to user inquiries, support requests, and feedback.</li>
        <li>To send notifications about updates, promotions, and important alerts.</li>
        <li>To analyze app performance and troubleshoot issues.</li>
    </ul>

    <h2 class = "justify">3. Data Sharing & Third-Party Services</h2>
    <p class = "justify">We do <strong>not</strong> sell or rent your personal data to third parties. However, we may share data in the following cases:</p>
    <ul class = "justify">
        <li><strong>Service Providers:</strong> Trusted partners assisting in hosting, analytics, and technical support.</li>
        <li><strong>Legal Compliance:</strong> When required by law or in response to legal requests.</li>
        <li><strong>Advertising & Analytics:</strong> Third-party tools may track app performance and user engagement.</li>
    </ul>

    <h2 class = "justify">4. Data Retention & Deletion Policy</h2>

    <h3 class = "justify">4.1 Retention of User Data</h3>
    <ul class = "justify">
        <li>We retain user account information and uploaded content as long as the account remains active.</li>
        <li>Inactive user data may be removed to optimize app performance.</li>
    </ul>

    <h3 class = "justify">4.2 How Users Can Delete Their Data</h3>
    <ul class = "justify">
        <li><strong>Data Deletion Request:</strong> Users can request complete data removal via the <strong>Data Deletion Request Form</strong> available on our app.</li>
        <li><strong>Processing Time:</strong> We process deletion requests within <strong>7 business days</strong>. Once deleted, data cannot be recovered.</li>
    </ul>

    <h2 class = "justify">5. Security Measures</h2>
    <p class = "justify">We implement industry-standard security practices to protect your personal information. However, no online platform can guarantee 100% security. Users are responsible for safeguarding their account credentials.</p>

    <h2 class = "justify">6. Children's Privacy</h2>
    <p class = "justify">Our app is <strong>not intended for children under 13 years of age</strong>. We do not knowingly collect personal information from children. If we discover such data, we will delete it immediately.</p>

    <h2 class = "justify">7. Third-Party Links</h2>
    <p class = "justify">Our app may contain links to external websites or services. We are not responsible for the privacy practices of those third parties. We recommend reviewing their privacy policies before sharing any information.</p>

    <h2 class = "justify">8. Updates to This Privacy Policy</h2>
    <p class = "justify">We may update this Privacy Policy periodically to reflect changes in our services or legal requirements. Any modifications will be posted here, and significant changes may be communicated to users through notifications.</p>

    <h2 class = "justify">9. Contact Us</h2>
    <p class = "justify">If you have any questions or concerns about this Privacy Policy, please contact us:</p>

    <p class = "justify"><strong>Email:</strong> <a href="mailto:admin@jobcircularlive.com">admin@jobcircularlive.com</a></p>
   <!-- <p class = "justify"><strong>Website:</strong> <a href="https://bcsapp.com">https://bcsapp.com</a></p>-->

</body>''';
      case 'Disclaimer':
        return '''
<body>
    <h2 class = "justify">No Government Affiliation</h2>
    <p class="justify" ><strong>BCS Question & Exam</strong> is an independent educational platform designed to assist candidates in preparing for the Bangladesh Civil Service (BCS) examination. Our app is <strong>not affiliated with, endorsed by, or officially connected to the Bangladesh Public Service Commission (BPSC) or any government agency</strong>. All content provided in this app is for informational and educational purposes only.</p>

    <h2 class = "justify">Information Sources</h2>
    <p class = "justify">The questions, explanations, and study materials in this app are compiled from multiple reliable sources, including:</p>
    <ul class = "justify">
        <li><strong>Uttoron Academy:</strong> A well-known platform for BCS Question & Exam. Visit <a href="https://uttoron.academy/QuestionBank" target="_blank">Uttoron Academy</a> for more details.</li>
        <li><strong>Publicly Available Resources:</strong> Information is collected from publicly accessible educational materials and past exam papers.</li>
        <li><strong>Official Circulars & Guidelines:</strong> Official notices and circulars from the <a href="https://bpsc.gov.bd/" target="_blank">Bangladesh Public Service Commission (BPSC)</a> are referred to ensure accurate and up-to-date information.</li>
    </ul>
    <p class = "justify">We strive to maintain the accuracy of all content; however, we do not guarantee that all information is free from errors, omissions, or outdated details.</p>

    <h2 class = "justify">Use of Information</h2>
    <p class = "justify">The content in this app is provided for general study purposes only. While we aim to offer accurate and up-to-date information, we do <strong>not</strong> guarantee the completeness, reliability, or accuracy of the materials. Users should verify details from official sources before making any decisions related to the BCS exam.</p>

    <h2 class = "justify">No Legal or Professional Advice</h2>
    <p class = "justify">The information provided in this app should not be considered legal, financial, or professional advice. If you require specific assistance, please consult relevant experts or official authorities.</p>

    <h2 class = "justify">Changes & Updates</h2>
    <p class = "justify">We reserve the right to modify, update, or remove content at any time without prior notice. Users are encouraged to check for updates regularly to ensure they have access to the latest study materials.</p>

    <h2 class = "justify">Contact Us</h2>
    <p class = "justify">If you have any questions about this Disclaimer, please contact us:</p>
    
    <p class = "justify"><strong>Email:</strong> <a href="mailto:admin@jobcircularlive.com">admin@jobcircularlive.com</a></p>

</body>''';
      case 'About Us':
      default:
        return '''
<body>
    <p class = "justify">Welcome to <strong>BCS Question & Exam</strong>, your ultimate companion for acing the Bangladesh Civil Service (BCS) exam. Our app is designed to help BCS aspirants prepare effectively and efficiently, with a variety of features that cover all aspects of the exam preparation process.</p>

    <h2 class = "justify">Our Mission</h2>
    <p class = "justify">Our mission is to provide a comprehensive and structured platform that equips BCS candidates with the tools and resources they need to succeed. We aim to simplify the learning process by offering previous year questions, model tests, subject-wise quizzes, and customized exam options. Whether you're just starting or looking to improve your exam strategy, our app provides an easy-to-use interface that fits into your busy study schedule.</p>

    <h2 class = "justify">What We Offer</h2>
    <ul class = "justify">
        <li><strong>Previous Year Questions:</strong> Access detailed solutions and explanations for past BCS preliminary exams to understand the pattern and answer strategies.</li>
        <li><strong>Model Tests:</strong> Simulate real exam conditions with full-length practice exams based on actual BCS questions.</li>
        <li><strong>Subject-Wise Tests:</strong> Focus your preparation on specific subjects to strengthen areas where you need improvement.</li>
        <li><strong>Customized Exams:</strong> Design your own practice tests based on selected topics and difficulty levels, tailored to your needs.</li>
        <li><strong>Instant Results & Analytics:</strong> Track your progress with performance analysis, and identify strengths and areas for improvement.</li>
        <li><strong>User-Friendly Interface:</strong> A fast, simple, and intuitive design that ensures an optimal learning experience.</li>
    </ul>

    <h2 class = "justify">Why Choose Us?</h2>
    <p class = "justify">At <strong>BCS Question & Exam</strong>, we understand the importance of a well-rounded approach to exam preparation. That’s why we offer resources that combine real-world exam practice with a structured learning approach. Our app is developed to help you:</p>
    <ul class = "justify">
        <li>Enhance your understanding of BCS exam patterns and question types.</li>
        <li>Improve your time management with timed mock exams and subject-focused practice.</li>
        <li>Track your progress with real-time results and detailed analytics to make smarter study decisions.</li>
        <li>Access reliable and credible resources to guide your preparation journey.</li>
    </ul>

    <h2 class = "justify">Our Commitment</h2>
    <p class = "justify">We are committed to supporting BCS candidates every step of the way. We continuously update the content, refine our features, and improve the overall user experience to ensure that you have access to the most effective tools for exam success.</p>

    <h2 class = "justify">Start Your BCS Journey Today!</h2>
    <p class = "justify"><strong>Download BCS Question & Exam now</strong> and take the first step towards success in the BCS examination. With the right tools, guidance, and support, you’ll be ready to face the challenges of the BCS exam with confidence!</p>
</body>''';
    }
  }
}
