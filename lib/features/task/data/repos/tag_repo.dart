import 'package:focus_app/features/task/data/services/tag_services.dart';
import 'package:focus_app/features/task/models/tag_model.dart';
import 'package:focus_app/utils/exceptions/handle_exception/handle_throw_exception.dart';

class TagRepo {
  // single ton
  static final TagRepo _instance = TagRepo._internal();
  TagRepo._internal();
  factory TagRepo() => _instance;

  // variables
  final _tagServices = TagServices();

  Future<bool> createTag (TagModel tag) async {
    return await HandleThrowException<bool>(() async {
      final res = await _tagServices.createTag(tag);
      return res > 0 ? true : false;
    });
  }

  Future<List<TagModel>> getAll({
    int page = 1,
    int limit = 99999
  }) async {
    return await HandleThrowException(() async {
      final tags = await _tagServices.getAll(page: page, limit: limit);

      return tags.map((a) => TagModel.fromJson(a)).toList();
    });
  }

  Future<TagModel> getTagById (int tagId) async {
    return await HandleThrowException<TagModel>(() async {
      final res = await _tagServices.getTagById(tagId);
      return TagModel.fromJson(res);
    });
  }

  Future<void> updateTag(TagModel tag) async {
    return await HandleThrowException<void>(() async {
      if (tag.tagId == null) {
        throw Exception('Cannot update tag without ID');
      }

      final res = await _tagServices.updateTag(tag);
      
      if(res == 0) {
        throw Exception("Update tag faile");
      }
    });
  }

  Future<void> deleteTag(int tagId) async {
    return await HandleThrowException<void>(() async {
      final res = await _tagServices.deleteTag(tagId);
      
      if(res == 0) {
        throw Exception("Delete tag faile");
      }
    });
  }
}