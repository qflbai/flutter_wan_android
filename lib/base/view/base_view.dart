import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/base/state/view_state.dart';
import 'package:flutter_wan_android/base/view_modle/base_view_model.dart';
import 'package:provider/provider.dart';


class ProviderWidget<MV extends BaseViewModel> extends StatefulWidget {
  final ValueWidgetBuilder<MV> builder;
  final MV model;
  final Widget child;
  final Function(MV model) onReady;
  final bool autoDispose;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
    this.onReady,
    this.autoDispose: true,
  }) : super(key: key);

  _ProviderWidgetState<MV> createState() => _ProviderWidgetState<MV>();
}

class _ProviderWidgetState<MV extends BaseViewModel> extends State<ProviderWidget<MV>> {
  MV model;

  @override
  void initState() {
    model = widget.model;
    widget.onReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) model.dispose();
    super.dispose();
  }

  Widget showEmpty() {
    return Icon(Icons.border_color);
  }

  Widget showLoging() {
    return Icon(Icons.cached);
  }

  Widget showError() {
    return Icon(Icons.error);
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MV>.value(
      value: model,
      child: Consumer<MV>(
        child: widget.child,
        builder:widget.builder/*(context, model, child) {
          if (model.viewState == ViewState.loading) {
            return showLoging();
          } else if (model.viewState == ViewState.empty) {
            return showEmpty();
          } else if (model.viewState == ViewState.error) {
            return showError();
          } else {
            return widget.builder(context,model,child);
          }
        }*/,
      ),
    );
  }
}
