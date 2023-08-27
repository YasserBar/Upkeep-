import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upkeep_plus/core/aseets/assets.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import 'package:upkeep_plus/features/services/domain/entities/service_foundation.dart';
import 'package:upkeep_plus/features/services/presentation/pages/customer/service%20_details_page.dart';

class ServicefoundationsDetailsItem extends StatefulWidget {
  const ServicefoundationsDetailsItem({
    super.key,
    required this.service,
  });
  final ServiceFoundation service;

  @override
  State<ServicefoundationsDetailsItem> createState() =>
      _ServicefoundationsDetailsItemState();
}

class _ServicefoundationsDetailsItemState
    extends State<ServicefoundationsDetailsItem> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ServiceDetails(
            service: widget.service,
          ),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: secondryColor, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.only(top: 10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.service.photo,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      AssetClass.StaticLogo,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  widget.service.service_name,
                  style: const TextStyle(
                    color: secondryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.service.services_description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "المؤسسة: ${widget.service.foundations_name}",
                        style: const TextStyle(
                          color: secondryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.service.foundations_description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: secondryColor,
                            ),
                          ),
                          Text(
                            "${widget.service.countries_name}-${widget.service.cities_name}-${widget.service.regions_name}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.watch_later_outlined,
                              color: secondryColor,
                            ),
                          ),
                          Text(
                            widget.service.duration_work,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ))),
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: secondryColor,
                        ),
                      ),
                      Text(
                        widget.service.service_cost.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
