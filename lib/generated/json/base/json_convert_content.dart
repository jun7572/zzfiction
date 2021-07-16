// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:zzfiction/bean/recommend_entity.dart';
import 'package:zzfiction/generated/json/recommend_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case RecommendEntity:
				return recommendEntityFromJson(data as RecommendEntity, json) as T;
			case RecommendRanking:
				return recommendRankingFromJson(data as RecommendRanking, json) as T;
			case RecommendRankingBooks:
				return recommendRankingBooksFromJson(data as RecommendRankingBooks, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case RecommendEntity:
				return recommendEntityToJson(data as RecommendEntity);
			case RecommendRanking:
				return recommendRankingToJson(data as RecommendRanking);
			case RecommendRankingBooks:
				return recommendRankingBooksToJson(data as RecommendRankingBooks);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (RecommendEntity).toString()){
			return RecommendEntity().fromJson(json);
		}	else if(type == (RecommendRanking).toString()){
			return RecommendRanking().fromJson(json);
		}	else if(type == (RecommendRankingBooks).toString()){
			return RecommendRankingBooks().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<RecommendEntity>[] is M){
			return data.map<RecommendEntity>((e) => RecommendEntity().fromJson(e)).toList() as M;
		}	else if(<RecommendRanking>[] is M){
			return data.map<RecommendRanking>((e) => RecommendRanking().fromJson(e)).toList() as M;
		}	else if(<RecommendRankingBooks>[] is M){
			return data.map<RecommendRankingBooks>((e) => RecommendRankingBooks().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}