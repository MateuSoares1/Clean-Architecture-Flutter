import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gitHub_search/modules/search/presenter/search/search_bloc.dart';
import 'package:gitHub_search/modules/search/presenter/state/search_state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();
  

  @override
  void dispose() {
    
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Search....  "),
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchStart) {
                    return Center(
                      child: Text('Digite um texto'),
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text('Houve um erro'),
                    );
                  }
                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final list = (state as SearchSucess).list;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: item.avatar_url == null
                            ? CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(item.avatar_url),
                              ),
                        title: Text(item.login ?? "sem titulo")                        
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
