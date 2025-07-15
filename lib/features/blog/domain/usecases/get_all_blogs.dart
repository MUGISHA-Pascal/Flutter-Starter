import 'package:flutter_starter/core/error/failures.dart';
import 'package:flutter_starter/core/usecase/usecase.dart';
import 'package:flutter_starter/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:flutter_starter/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepositoryImpl blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
