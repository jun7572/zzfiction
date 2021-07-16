import 'package:zzfiction/generated/json/base/json_convert_content.dart';
import 'package:zzfiction/generated/json/base/json_field.dart';

class RecommendEntity with JsonConvert<RecommendEntity> {
	RecommendRanking ranking;
	bool ok;
}

class RecommendRanking with JsonConvert<RecommendRanking> {
	@JSONField(name: "_id")
	String sId;
	String updated;
	String title;
	String tag;
	String cover;
	String icon;
	@JSONField(name: "__v")
	int iV;
	String monthRank;
	String totalRank;
	String shortTitle;
	String created;
	String biTag;
	bool isSub;
	bool collapse;
	@JSONField(name: "new")
	bool xNew;
	String gender;
	int priority;
	List<RecommendRankingBooks> books;
	String id;
	int total;
}

class RecommendRankingBooks with JsonConvert<RecommendRankingBooks> {
	@JSONField(name: "_id")
	String sId;
	String title;
	String majorCate;
	String shortIntro;
	String minorCate;
	String site;
	String author;
	String cover;
	bool allowMonthly;
	int banned;
	int latelyFollower;
	String retentionRatio;
}
