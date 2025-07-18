import 'package:flutter_starter/core/common/widgets/loader.dart';
import 'package:flutter_starter/core/theme/app_pallete.dart';
import 'package:flutter_starter/core/utils/show_snackbar.dart';
import 'package:flutter_starter/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_starter/features/blog/presentation/pages/add_new_blog%20_page.dart';
import 'package:flutter_starter/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_starter/features/auth/presentation/pages/login_page.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            LoginPage.route(),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog App'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
              },
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            if (state is BlogsDisplaySuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: index % 2 == 0
                        ? AppPallete.gradient1
                        : AppPallete.gradient2,
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
