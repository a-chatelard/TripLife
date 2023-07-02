import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/add_vacation_bloc/add_vacation_bloc.dart';
import 'package:trip_life/application/blocs/vacation_list_bloc/vacation_list_bloc.dart';
import 'package:trip_life/entity/models/address.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/shared/overlay_entry/loader_overlay_entry.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/previous_screen_app_bar.dart';

class AddVacationPage extends StatefulWidget {
  const AddVacationPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddVacationPage());
  }

  @override
  State<AddVacationPage> createState() => _AddVacationPageState();
}

class _AddVacationPageState extends State<AddVacationPage>
    with RestorationMixin {
  OverlayEntry? overlayEntry = LoaderOverlayEntry.build();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  final RestorableDateTimeN _selectedStartDate =
      RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _selectedEndDate =
      RestorableDateTimeN(DateTime.now());

  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _selectedStartDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _selectedEndDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedStartDate.value = newSelectedDate.start;
        _startDateController.text = dateFormatter.format(newSelectedDate.start);
        _selectedEndDate.value = newSelectedDate.end;
        _endDateController.text = dateFormatter.format(newSelectedDate.end);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final vacationsListBloc = BlocProvider.of<VacationListBloc>(context);

    return BlocProvider(
        create: (_) => AddVacationBloc(
            vacationRepository:
                serviceLocator.get<AbstractVacationRepository>()),
        child: BlocConsumer<AddVacationBloc, AddVacationState>(
            listener: (context, state) {
          // if (state.status.isSuccessful) {
          //   vacationsListBloc.add(VacationListRequest());
          // }
        }, builder: (context, state) {
          if (state.status.isSuccessful || state.status.isFailed) {
            overlayEntry?.remove();
          }
          if (state.status.isSuccessful) {
            Timer(const Duration(milliseconds: 1000),
                () => Navigator.of(context).pop());
          }
          if (state.status.isFailed) {}

          return Scaffold(
              appBar: const PreviousScreenAppBar(),
              body: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                        controller: _labelController,
                        decoration: const InputDecoration(
                            hintText: 'Donnez un titre à votre voyage')),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Saisissez une date de début'),
                      controller: _startDateController,
                      onTap: () {
                        _restorableDateRangePickerRouteFuture.present();
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Saisissez une date de fin'),
                      controller: _endDateController,
                      onTap: () {
                        _restorableDateRangePickerRouteFuture.present();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Rue'),
                        controller: _streetController),
                    TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Code postal'),
                        controller: _zipCodeController),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Ville'),
                        controller: _cityController),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Région'),
                        controller: _stateController),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'Pays'),
                        controller: _countryController),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Budget prévu'),
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d*)')),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Overlay.of(context, debugRequiredFor: widget)
                              .insert(overlayEntry!);
                          context.read<AddVacationBloc>().add(
                              AddVacationRequest(
                                  _labelController.text,
                                  _selectedStartDate.value!,
                                  _selectedEndDate.value!,
                                  Address(
                                      _streetController.text,
                                      _cityController.text,
                                      _stateController.text,
                                      _countryController.text,
                                      _zipCodeController.text),
                                  double.parse(_budgetController.text)));
                        },
                        child: const Text('Valider'))
                  ],
                ),
              ));
        }));
  }

  @pragma('vm:entry-point')
  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(DateTime.now().year),
          currentDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 20),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  @override
  String? get restorationId => "start_date";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedStartDate, 'start_date');
    registerForRestoration(_selectedEndDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  @override
  void dispose() {
    _labelController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _streetController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _budgetController.dispose();
    _budgetController.dispose();
    super.dispose();
  }
}
