import 'package:zzfiction/bean/recommend_entity.dart';

recommendEntityFromJson(RecommendEntity data, Map<String, dynamic> json) {
	if (json['ranking'] != null) {
		data.ranking = RecommendRanking().fromJson(json['ranking']);
	}
	if (json['ok'] != null) {
		data.ok = json['ok'];
	}
	return data;
}

Map<String, dynamic> recommendEntityToJson(RecommendEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ranking'] = entity.ranking?.toJson();
	data['ok'] = entity.ok;
	return data;
}

recommendRankingFromJson(RecommendRanking data, Map<String, dynamic> json) {
	if (json['_id'] != null) {
		data.sId = json['_id'].toString();
	}
	if (json['updated'] != null) {
		data.updated = json['updated'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['tag'] != null) {
		data.tag = json['tag'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['icon'] != null) {
		data.icon = json['icon'].toString();
	}
	if (json['__v'] != null) {
		data.iV = json['__v'] is String
				? int.tryParse(json['__v'])
				: json['__v'].toInt();
	}
	if (json['monthRank'] != null) {
		data.monthRank = json['monthRank'].toString();
	}
	if (json['totalRank'] != null) {
		data.totalRank = json['totalRank'].toString();
	}
	if (json['shortTitle'] != null) {
		data.shortTitle = json['shortTitle'].toString();
	}
	if (json['created'] != null) {
		data.created = json['created'].toString();
	}
	if (json['biTag'] != null) {
		data.biTag = json['biTag'].toString();
	}
	if (json['isSub'] != null) {
		data.isSub = json['isSub'];
	}
	if (json['collapse'] != null) {
		data.collapse = json['collapse'];
	}
	if (json['new'] != null) {
		data.xNew = json['new'];
	}
	if (json['gender'] != null) {
		data.gender = json['gender'].toString();
	}
	if (json['priority'] != null) {
		data.priority = json['priority'] is String
				? int.tryParse(json['priority'])
				: json['priority'].toInt();
	}
	if (json['books'] != null) {
		data.books = (json['books'] as List).map((v) => RecommendRankingBooks().fromJson(v)).toList();
	}
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	return data;
}

Map<String, dynamic> recommendRankingToJson(RecommendRanking entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['_id'] = entity.sId;
	data['updated'] = entity.updated;
	data['title'] = entity.title;
	data['tag'] = entity.tag;
	data['cover'] = entity.cover;
	data['icon'] = entity.icon;
	data['__v'] = entity.iV;
	data['monthRank'] = entity.monthRank;
	data['totalRank'] = entity.totalRank;
	data['shortTitle'] = entity.shortTitle;
	data['created'] = entity.created;
	data['biTag'] = entity.biTag;
	data['isSub'] = entity.isSub;
	data['collapse'] = entity.collapse;
	data['new'] = entity.xNew;
	data['gender'] = entity.gender;
	data['priority'] = entity.priority;
	data['books'] =  entity.books?.map((v) => v.toJson())?.toList();
	data['id'] = entity.id;
	data['total'] = entity.total;
	return data;
}

recommendRankingBooksFromJson(RecommendRankingBooks data, Map<String, dynamic> json) {
	if (json['_id'] != null) {
		data.sId = json['_id'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['majorCate'] != null) {
		data.majorCate = json['majorCate'].toString();
	}
	if (json['shortIntro'] != null) {
		data.shortIntro = json['shortIntro'].toString();
	}
	if (json['minorCate'] != null) {
		data.minorCate = json['minorCate'].toString();
	}
	if (json['site'] != null) {
		data.site = json['site'].toString();
	}
	if (json['author'] != null) {
		data.author = json['author'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['allowMonthly'] != null) {
		data.allowMonthly = json['allowMonthly'];
	}
	if (json['banned'] != null) {
		data.banned = json['banned'] is String
				? int.tryParse(json['banned'])
				: json['banned'].toInt();
	}
	if (json['latelyFollower'] != null) {
		data.latelyFollower = json['latelyFollower'] is String
				? int.tryParse(json['latelyFollower'])
				: json['latelyFollower'].toInt();
	}
	if (json['retentionRatio'] != null) {
		data.retentionRatio = json['retentionRatio'].toString();
	}
	return data;
}

Map<String, dynamic> recommendRankingBooksToJson(RecommendRankingBooks entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['_id'] = entity.sId;
	data['title'] = entity.title;
	data['majorCate'] = entity.majorCate;
	data['shortIntro'] = entity.shortIntro;
	data['minorCate'] = entity.minorCate;
	data['site'] = entity.site;
	data['author'] = entity.author;
	data['cover'] = entity.cover;
	data['allowMonthly'] = entity.allowMonthly;
	data['banned'] = entity.banned;
	data['latelyFollower'] = entity.latelyFollower;
	data['retentionRatio'] = entity.retentionRatio;
	return data;
}