import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dog_app/features/breed/presentation/bloc/breed_bloc.dart';
import 'package:dog_app/features/breed/presentation/widgets/breed_grid.dart';
import 'package:dog_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BreedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            title: Text(
              "Look for your dog",
              style: Theme.of(context).textTheme.headline5,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    "Click in a breed to see all the dogs of that breed",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (_) => sl<BreedBloc>()..add(GetAllBreeds()),
              child: BlocBuilder<BreedBloc, BreedState>(
                builder: (context, state) {
                  if (state is Loaded) {
                    return BreedGrid(breeds: state.breeds);
                  } else if (state is Error) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
