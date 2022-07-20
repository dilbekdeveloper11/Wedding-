import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wedding_app/blocs/galery/galery_bloc.dart';
import 'package:wedding_app/blocs/location/location_bloc.dart';
import 'package:wedding_app/blocs/order/order_bloc.dart';
import 'package:wedding_app/blocs/service/service_bloc.dart';
import 'package:wedding_app/ui/register_page/register_page.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/base/base_bloc.dart';
import '../../blocs/event/event_bloc.dart';
import '../../main.dart';
import '../../providers/token_provider.dart';
import 'widgets/bottom_widget.dart';
import 'widgets/event_item.dart';
import 'widgets/event_location_item.dart';
import 'widgets/galery_group.dart';
import 'widgets/galery_item.dart';
import 'widgets/header_widget.dart';
import 'widgets/order_button.dart';
import 'widgets/order_popup_card.dart';
import 'widgets/service_card.dart';
import 'widgets/title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TokenDataProvider _tokenProvider = TokenDataProvider();

  int _selectedEvent = 0;
  int _selectedLocation = 0;
  bool isTapped = false;
  int? _selectedEventId;

  List serviceId = [];

  bool isAvailable = true;

  // await final token = _tokenProvider.box.read('tokenID');
  String? token;

  @override
  void initState() {
    super.initState();
    token = _tokenProvider.box.read('tokenID');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<BaseBloc>(
            create: (context) => BaseBloc()..add(BaseLoad()),
          ),
          BlocProvider<EventBloc>(
            create: (context) => EventBloc()..add(EventLoad()),
          ),
          BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
          BlocProvider<GaleryBloc>(
            create: (context) => GaleryBloc()..add(GaleryLoad()),
          ),
          BlocProvider<ServiceBloc>(
            create: (context) => ServiceBloc()..add(ServiceLoad()),
          ),
          BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(),
          ),
        ],
        child: CustomScrollView(
          slivers: [
            // ? AppBar
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              expandedHeight: 56.h,
              title: Image.asset('assets/images/logo.png'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      ).then((value) {
                        context
                            .read<LocationBloc>()
                            .add(LocationLoad(_selectedEventId ?? 1));
                      });
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ))
              ],
            ),
            // ? Header Slider
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 56.h,
                child: BlocBuilder<BaseBloc, BaseState>(
                  builder: (context, state) {
                    if (state is BaseLoading) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.yellow,
                        ),
                      );
                    }
                    if (state is BaseLoaded) {
                      return HeaderWidget(
                        baseList: state.base,
                      );
                    }
                    if (state is BaseError) {
                      return const SizedBox.shrink();
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.yellow,
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            // ? Title
            const SliverToBoxAdapter(child: TitleWidget(title: 'Галерея')),
            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            // ?Galery
            SliverToBoxAdapter(
              child: SizedBox(
                height: 335.h,
                child: CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, _) {
                    return const GaleryGroup(
                      urlOne: 'assets/images/galery.png',
                      urlTwo: 'assets/images/galery2.png',
                      urlThree: 'assets/images/galery3.png',
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    height: 335.h,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15.h)),
            SliverToBoxAdapter(
              child: BlocBuilder<GaleryBloc, GaleryState>(
                builder: (context, state) {
                  if (state is GaleryLoading) {
                    return SizedBox(
                      height: 280.h,
                      child: CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index, _) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 230.w,
                              height: 280.h,
                              color: Colors.yellow,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          height: 335.h,
                        ),
                      ),
                    );
                  }
                  if (state is GaleryLoaded) {
                    if (state.galeries.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return CarouselSlider.builder(
                      itemCount: state.galeries[0].images?.length,
                      itemBuilder: (context, index, _) {
                        final galery = state.galeries[0];
                        return GaleryItem(
                          id: galery.id,
                          name: galery.name,
                          type: galery.type,
                          description: galery.description,
                          imageId: galery.images![index].id.toString(),
                          imageUrl: galery.images![index].image,
                        );
                      },
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        height: 335.h,
                      ),
                    );
                  }
                  if (state is GaleryErorr) {
                    return const Center(child: Text("ERORR"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            // ?Title
            SliverToBoxAdapter(
                key: dataKey, child: const TitleWidget(title: 'Мероприятия')),
            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            //? Event Slider
            SliverToBoxAdapter(
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return SizedBox(
                      height: 280.h,
                      child: CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index, _) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 230.w,
                              height: 280.h,
                              color: Colors.yellow,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          height: 280.h,
                        ),
                      ),
                    );
                  }
                  if (state is EventErorr) {
                    return const Center(child: Text("ERORR"));
                  }
                  if (state is EventLoaded) {
                    if (state.events.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return SizedBox(
                      height: 280.h,
                      child: CarouselSlider.builder(
                        itemCount: state.events.length,
                        itemBuilder: (context, index, _) {
                          final event = state.events[index];
                          return EventItem(
                            id: event.id,
                            name: event.name,
                            text: event.description,
                            imageUrl: event.image ?? '',
                            isSelected:
                                _selectedEvent == index ? isTapped : false,
                            onTap: () {
                              setState(() {
                                _selectedEvent = index;
                                if (_selectedEvent == index) {
                                  isTapped = !isTapped;
                                  _selectedEventId = event.id;
                                  context
                                      .read<LocationBloc>()
                                      .add(LocationLoad(_selectedEventId!));
                                }
                              });
                            },
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          height: 280.h,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            //? Title
            SliverToBoxAdapter(
                child: (token != null && _selectedEventId != null)
                    ? const TitleWidget(title: 'Заведения мероприятии')
                    : null),
            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            //? Event Location Slider
            SliverToBoxAdapter(
              child: BlocListener(
                bloc: BlocProvider.of<AuthBloc>(context),
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    if (_selectedEventId != null) {
                      context
                          .read<LocationBloc>()
                          .add(LocationLoad(_selectedEventId!));
                    }
                  }
                },
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationError) {
                      return const Center(child: Text("ERORR"));
                    }
                    if (state is LocationLoading) {
                      return SizedBox(
                        height: 280.h,
                        child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, _) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 230.w,
                                height: 280.h,
                                color: Colors.yellow,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.6,
                            enlargeCenterPage: true,
                            height: 280.h,
                          ),
                        ),
                      );
                    }
                    if (state is LocationLoaded) {
                      if (state.locations.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return SizedBox(
                        height: 280.h,
                        child: CarouselSlider.builder(
                          itemCount: state.locations.length,
                          itemBuilder: (context, index, _) {
                            final location = state.locations[index];
                            return EventLocationItem(
                              id: location.id,
                              image: location.image,
                              name: location.name,
                              isSelected:
                                  _selectedLocation == index ? true : false,
                              onTap: () {
                                setState(() {
                                  _selectedLocation = index;
                                });
                              },
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.6,
                            enlargeCenterPage: true,
                            height: 280.h,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            // ? Title
            SliverToBoxAdapter(
                child: (token != null && _selectedEventId != null)
                    ? const TitleWidget(title: 'Услуги')
                    : null),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            //? Service Card
            SliverToBoxAdapter(
              child: (token != null && _selectedEventId != null)
                  ? BlocBuilder<ServiceBloc, ServiceState>(
                      builder: (context, state) {
                        if (state is ServiceLoading) {
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              height: 174.h,
                              width: double.infinity,
                            ),
                          );
                        }
                        if (state is ServiceError) {
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            height: 174.h,
                            width: double.infinity,
                            child: const Icon(Icons.error),
                          );
                        }

                        if (state is ServiceLoaded) {
                          return SingleChildScrollView(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.services.length,
                              itemBuilder: ((context, index) {
                                final service = state.services[index];
                                return ServiceCard(
                                  serviceIdList: serviceId,
                                  onTap: () {
                                    if (serviceId.contains(service.id)) {
                                      serviceId.remove(service.id);
                                    } else {
                                      serviceId.add(service.id);
                                    }
                                    setState(() {});
                                  },
                                  id: service.id,
                                  image: service.image,
                                  description: service.description,
                                  name: service.name,
                                  price: service.price,
                                  type: service.type,
                                );
                              }),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    )
                  : null,
            ),
            SliverToBoxAdapter(
                child: (token != null && _selectedEventId != null)
                    ? SizedBox(height: 30.h)
                    : null),
            // ?Order Button
            SliverToBoxAdapter(
              child: (token != null && _selectedEventId != null)
                  ? BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (state is OrderLoaded) {
                          _showDialog(context);
                        }
                        return OrderButton(onTap: () {
                          if (_selectedEventId != null &&
                              serviceId.isNotEmpty) {
                            context.read<OrderBloc>().add(OrderLoad(
                                id: _selectedEventId!, serives: serviceId));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red[700],
                                content: const Text('Выберите нужные поля')));
                          }
                        });
                      },
                    )
                  : null,
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            // ? Social Buttons
            const SliverToBoxAdapter(child: BottomWidget()),
          ],
        ),
      ),
    );
  }
}

_showDialog(BuildContext context) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   const SnackBar(
  //     backgroundColor: Colors.transparent,
  //     duration: Duration(milliseconds: 1000),
  //     content: OrderPopupCard(),
  //   ),
  // );

  showDialog(context: context, builder: (_){
    return OrderPopupCard();
  });
}
