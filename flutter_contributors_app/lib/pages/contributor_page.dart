// lib/pages/contributor_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contributor_bloc.dart';
import '../bloc/contributor_event.dart';
import '../bloc/contributor_state.dart';
import '../models/contributor.dart';
import 'contributor_detail_page.dart';

class ContributorPage extends StatefulWidget {
  @override
  _ContributorPageState createState() => _ContributorPageState();
}

class _ContributorPageState extends State<ContributorPage> {
  final TextEditingController _searchController = TextEditingController();
  late ContributorBloc _contributorBloc;

  @override
  void initState() {
    super.initState();
    _contributorBloc = BlocProvider.of<ContributorBloc>(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _contributorBloc.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _contributorBloc.add(RefreshContributors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Contributors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contributors',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _contributorBloc.add(SearchContributors(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ContributorBloc, ContributorState>(
              builder: (context, state) {
                if (state is ContributorLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ContributorLoaded) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: state.contributors.length,
                      itemBuilder: (context, index) {
                        Contributor contributor = state.contributors[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(contributor.avatarUrl),
                          ),
                          title: Text(contributor.login),
                          subtitle: Text(
                              '${contributor.type} - ${contributor.userViewType ?? 'N/A'}'),
                          onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ContributorDetailPage(contributor: contributor),
                            ),
                          );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is ContributorError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('No contributors found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
