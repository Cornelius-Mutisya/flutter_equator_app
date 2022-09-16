import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poc_app/models/new_token_model.dart';
import 'package:poc_app/services/fetch_data.dart';
import 'package:poc_app/utils/colors.dart';
import 'package:poc_app/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initilize the service
  final repo = FetchDataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'eQ',
          style: kBodyStyle.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: const [],
      ),
      body: SafeArea(
        child: StreamBuilder<List<TokenInfo>>(
          stream: repo.fetchPrices(),
          builder: (context, AsyncSnapshot<List<TokenInfo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColor,
              ));
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    return TokenWidget(
                      // tokenIcon: MdiIcons.ethereum,
                      tokenPrice: '${snapshot.data?[index].price}',
                      tokenSymbol: '${snapshot.data?[index].symbol}',
                      tokenColor: Colors.blue,
                    );
                  }),
                );
              } else {
                return Center(
                  child: Text(
                    'Empty data',
                    style: kBodyStyle,
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  'State: ${snapshot.connectionState}',
                  style: kBodyStyle,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class TokenWidget extends StatelessWidget {
  final String tokenSymbol;
  final String tokenPrice;
  final Color tokenColor;

  const TokenWidget({
    Key? key,
    required this.tokenSymbol,
    required this.tokenPrice,
    required this.tokenColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 1.0,
            offset: const Offset(4.0, 2.0),
            blurRadius: 2.0,
          )
        ],
        color: Colors.black,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            MdiIcons.account,
            color: tokenColor,
          ),
        ),
        title: Text(
          tokenSymbol,
          style: kBodyStyle.copyWith(
            color: kPrimaryColor,
          ),
        ),
        trailing: RichText(
          text: TextSpan(
            text: '\$ ',
            style: kBodyStyle.copyWith(
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: tokenPrice,
                style: kBodyStyle.copyWith(
                  color: kPrimaryColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
