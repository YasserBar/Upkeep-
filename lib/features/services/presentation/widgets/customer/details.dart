import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class Details extends StatelessWidget {
  final String description;

  const Details({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // double width=MediaQuery.of(context).size.width;
    // double detailsWidth=(358/390)*width;
    return AutoSizeText(
      description,
      // "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق"
      //     "إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع"
      //     "ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق",

      maxFontSize: 18,
      minFontSize: 10,

      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: primaryColor),
      textAlign: TextAlign.left,
      textDirection: TextDirection.rtl,
    );
  }
}
