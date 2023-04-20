import 'package:flutter/material.dart';
import 'package:offertelavoroflutter/models/job_offer.dart';
import 'package:offertelavoroflutter/ui/components/shimmer.dart';

class JobOfferCardComponent extends StatelessWidget {
  final Recruitment? jobOffer;

  const JobOfferCardComponent({
    super.key,
    this.jobOffer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: jobOffer == null ? null : () => print('card premuta!'),
      child: Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Column(
            children: jobOffer == null ? contentCardShimmer : contentCard,
          ),
        ),
      ),
    );
  }

  List<Widget> get contentCard => [
    headerTop(jobOffer!),
    headerBottom(jobOffer!),
  ];

  Widget headerTop(Recruitment jobOffer) => ListTile(
    leading: Text(
      '${jobOffer.image}',
      style: const TextStyle(
        fontSize: 30.0,
      ),
    ),
    title: Text(
      '${jobOffer.name}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0
      ),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        jobOffer.pay ?? '',
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    ),
    trailing: IconButton(
      onPressed: () => print('Offerta salvata tra i preferiti :-)'),
      icon: const Icon(Icons.bookmark_add_outlined),
      iconSize: 30.0,
    ),
  );

  Widget headerBottom(Recruitment jobOffer) => Wrap(
    direction: Axis.horizontal,
    spacing: 10.0,
    children: [
      if(jobOffer.seniority?.text != null)
        Chip(
          label: Text(jobOffer.seniority!.text!),
          backgroundColor: jobOffer.seniority!.color,
        ),
      if(jobOffer.team?.text != null)
        Chip(
          label: Text(jobOffer.team!.text!),
          backgroundColor: jobOffer.team!.color,
        ),
      if(jobOffer.contract?.text != null)
        Chip(
          label: Text(jobOffer.contract!.text!),
          backgroundColor: jobOffer.contract!.color,
        ),
    ],
  );

  List<Widget> get contentCardShimmer => [
    headerTopShimmer(),
    headerBottomShimmer(),
  ];
  // skeleton shimmer
  Widget headerTopShimmer() => ListTile(
    leading: placeholderShimmerImage(),
    title: const ShimmerComponent.rectangular(height: 16.0),
    subtitle: const ShimmerComponent.rectangular(height: 14.0),
    trailing: const IconButton(
      onPressed: null,
      icon: Icon(Icons.bookmark_add_outlined),
      iconSize: 30.0,
    ),
  );

  // skeleton shimmer
  Widget headerBottomShimmer() => Wrap(
    direction: Axis.horizontal,
    spacing: 10.0,
    children: const [
      ShimmerComponent.rectangular(height: 14.0, width: 60),
      ShimmerComponent.rectangular(height: 14.0, width: 60),
      ShimmerComponent.rectangular(height: 14.0, width: 60),
    ],
  );

  Widget placeholderShimmerImage() => ShimmerComponent.circular(
    width: 64, 
    height: 64,
    shapeBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

}