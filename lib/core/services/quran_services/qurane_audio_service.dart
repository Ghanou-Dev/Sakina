import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/core/apis/quran_audio/reciter_endpoint.dart';
import 'package:sakina/core/apis/quran_audio/reciter_keys.dart';
import 'package:sakina/core/dto/reciter_dto.dart';

class QuraneAudioService {
  ApiConsumer api;
  QuraneAudioService({required this.api});

  Future<List<ReciterDto>> fetchAllReciters() async {
    final jsonData = await api.get(ReciterEndpoint.getAllRecitersUrl());
    // dynamic decodeData = jsonDecode(jsonData);
    return (jsonData[ReciterKeys.reciters] as List<dynamic>)
        .map((data) => ReciterDto.fromJson(data))
        .toList();
  }
}
