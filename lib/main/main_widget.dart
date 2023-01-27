import '../add_account/add_account_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../details/details_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../intropage/intropage_widget.dart';
import '../profile/profile_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  TextEditingController? textController;

  PagingController<DocumentSnapshot?, DataRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF0F0F0),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                          child: Image.asset(
                            'assets/images/cyphee.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(150, 0, 30, 0),
                            child: AuthUserStreamWidget(
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileWidget(),
                                    ),
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IntropageWidget(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    currentUserPhoto,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, -0.35),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                      child: TextFormField(
                        controller: textController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Search ',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.75, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                                child: Text(
                                  'My Credentials',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                                child: PagedListView<DocumentSnapshot<Object?>?,
                                    DataRecord>(
                                  pagingController: () {
                                    final Query<Object?> Function(
                                            Query<Object?>) queryBuilder =
                                        (dataRecord) =>
                                            dataRecord.orderBy('url');
                                    if (_pagingController != null) {
                                      final query =
                                          queryBuilder(DataRecord.collection());
                                      if (query != _pagingQuery) {
                                        // The query has changed
                                        _pagingQuery = query;
                                        _streamSubscriptions
                                            .forEach((s) => s?.cancel());
                                        _streamSubscriptions.clear();
                                        _pagingController!.refresh();
                                      }
                                      return _pagingController!;
                                    }

                                    _pagingController =
                                        PagingController(firstPageKey: null);
                                    _pagingQuery =
                                        queryBuilder(DataRecord.collection());
                                    _pagingController!.addPageRequestListener(
                                        (nextPageMarker) {
                                      queryDataRecordPage(
                                        parent: currentUserReference,
                                        queryBuilder: (dataRecord) =>
                                            dataRecord.orderBy('url'),
                                        nextPageMarker: nextPageMarker,
                                        pageSize: 7,
                                        isStream: true,
                                      ).then((page) {
                                        _pagingController!.appendPage(
                                          page.data,
                                          page.nextPageMarker,
                                        );
                                        final streamSubscription =
                                            page.dataStream?.listen((data) {
                                          final itemIndexes = _pagingController!
                                              .itemList!
                                              .asMap()
                                              .map((k, v) =>
                                                  MapEntry(v.reference.id, k));
                                          data.forEach((item) {
                                            final index =
                                                itemIndexes[item.reference.id];
                                            final items =
                                                _pagingController!.itemList!;
                                            if (index != null) {
                                              items.replaceRange(
                                                  index, index + 1, [item]);
                                              _pagingController!.itemList = {
                                                for (var item in items)
                                                  item.reference: item
                                              }.values.toList();
                                            }
                                          });
                                          setState(() {});
                                        });
                                        _streamSubscriptions
                                            .add(streamSubscription);
                                      });
                                    });
                                    return _pagingController!;
                                  }(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<DataRecord>(
                                    // Customize what your widget looks like when it's loading the first page.
                                    firstPageProgressIndicatorBuilder: (_) =>
                                        Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: SpinKitRipple(
                                          color: Color(0xFF113E21),
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    noItemsFoundIndicatorBuilder: (_) => Center(
                                      child: SvgPicture.asset(
                                        'assets/images/Nothing_to_show.svg',
                                      ),
                                    ),
                                    itemBuilder: (context, _, listViewIndex) {
                                      final listViewDataRecord =
                                          _pagingController!
                                              .itemList![listViewIndex];
                                      return InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsWidget(
                                                data: listViewDataRecord
                                                    .reference,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Slidable(
                                          actionPane:
                                              const SlidableScrollActionPane(),
                                          secondaryActions: [
                                            IconSlideAction(
                                              caption: '',
                                              color: Color(0xFF113E21),
                                              icon: Icons.delete_rounded,
                                              onTap: () async {
                                                await listViewDataRecord
                                                    .reference
                                                    .delete();
                                              },
                                            ),
                                          ],
                                          child: ListTile(
                                            title: Text(
                                              listViewDataRecord.url!,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title3,
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF303030),
                                              size: 20,
                                            ),
                                            tileColor: Color(0xFFF5F5F5),
                                            dense: false,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 10, 30, 10),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAccountWidget(),
                        ),
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 70,
                      constraints: BoxConstraints(
                        maxHeight: 48,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF113E21),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x32171717),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
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
