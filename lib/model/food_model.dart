// To parse this JSON data, do
//
//     final searchFood = searchFoodFromMap(jsonString);

import 'dart:convert';

SearchFood searchFoodFromMap(String str) => SearchFood.fromMap(json.decode(str));

String searchFoodToMap(SearchFood data) => json.encode(data.toMap());

class SearchFood {
    SearchFood({
        this.totalHits,
        this.currentPage,
        this.totalPages,
        this.pageList,
        this.foodSearchCriteria,
        this.foods,
        this.aggregations,
    });

    int? totalHits;
    int? currentPage;
    int? totalPages;
    List<int>? pageList;
    FoodSearchCriteria? foodSearchCriteria;
    List<Food>? foods;
    Aggregations? aggregations;

    SearchFood copyWith({
        int? totalHits,
        int? currentPage,
        int? totalPages,
        List<int>? pageList,
        FoodSearchCriteria? foodSearchCriteria,
        List<Food>? foods,
        Aggregations? aggregations,
    }) => 
        SearchFood(
            totalHits: totalHits ?? this.totalHits,
            currentPage: currentPage ?? this.currentPage,
            totalPages: totalPages ?? this.totalPages,
            pageList: pageList ?? this.pageList,
            foodSearchCriteria: foodSearchCriteria ?? this.foodSearchCriteria,
            foods: foods ?? this.foods,
            aggregations: aggregations ?? this.aggregations,
        );

    factory SearchFood.fromMap(Map<String, dynamic> json) => SearchFood(
        totalHits: json["totalHits"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        pageList: json["pageList"] == null ? [] : List<int>.from(json["pageList"]!.map((x) => x)),
        foodSearchCriteria: json["foodSearchCriteria"] == null ? null : FoodSearchCriteria.fromMap(json["foodSearchCriteria"]),
        foods: json["foods"] == null ? [] : List<Food>.from(json["foods"]!.map((x) => Food.fromMap(x))),
        aggregations: json["aggregations"] == null ? null : Aggregations.fromMap(json["aggregations"]),
    );

    Map<String, dynamic> toMap() => {
        "totalHits": totalHits,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "pageList": pageList == null ? [] : List<dynamic>.from(pageList!.map((x) => x)),
        "foodSearchCriteria": foodSearchCriteria?.toMap(),
        "foods": foods == null ? [] : List<dynamic>.from(foods!.map((x) => x.toMap())),
        "aggregations": aggregations?.toMap(),
    };
}

class Aggregations {
    Aggregations({
        this.dataType,
        this.nutrients,
    });

    DataType? dataType;
    Nutrients? nutrients;

    Aggregations copyWith({
        DataType? dataType,
        Nutrients? nutrients,
    }) => 
        Aggregations(
            dataType: dataType ?? this.dataType,
            nutrients: nutrients ?? this.nutrients,
        );

    factory Aggregations.fromMap(Map<String, dynamic> json) => Aggregations(
        dataType: json["dataType"] == null ? null : DataType.fromMap(json["dataType"]),
        nutrients: json["nutrients"] == null ? null : Nutrients.fromMap(json["nutrients"]),
    );

    Map<String, dynamic> toMap() => {
        "dataType": dataType?.toMap(),
        "nutrients": nutrients?.toMap(),
    };
}

class DataType {
    DataType({
        this.branded,
        this.surveyFndds,
        this.srLegacy,
    });

    int? branded;
    int? surveyFndds;
    int? srLegacy;

    DataType copyWith({
        int? branded,
        int? surveyFndds,
        int? srLegacy,
    }) => 
        DataType(
            branded: branded ?? this.branded,
            surveyFndds: surveyFndds ?? this.surveyFndds,
            srLegacy: srLegacy ?? this.srLegacy,
        );

    factory DataType.fromMap(Map<String, dynamic> json) => DataType(
        branded: json["Branded"],
        surveyFndds: json["Survey (FNDDS)"],
        srLegacy: json["SR Legacy"],
    );

    Map<String, dynamic> toMap() => {
        "Branded": branded,
        "Survey (FNDDS)": surveyFndds,
        "SR Legacy": srLegacy,
    };
}

class Nutrients {
    Nutrients();

    Nutrients copyWith() =>Nutrients();

    factory Nutrients.fromMap(Map<String, dynamic> json) => Nutrients(
    );

    Map<String, dynamic> toMap() => {
    };
}

class FoodSearchCriteria {
    FoodSearchCriteria({
        this.query,
        this.generalSearchInput,
        this.pageNumber,
        this.numberOfResultsPerPage,
        this.pageSize,
        this.requireAllWords,
    });

    String? query;
    String? generalSearchInput;
    int? pageNumber;
    int? numberOfResultsPerPage;
    int? pageSize;
    bool? requireAllWords;

    FoodSearchCriteria copyWith({
        String? query,
        String? generalSearchInput,
        int? pageNumber,
        int? numberOfResultsPerPage,
        int? pageSize,
        bool? requireAllWords,
    }) => 
        FoodSearchCriteria(
            query: query ?? this.query,
            generalSearchInput: generalSearchInput ?? this.generalSearchInput,
            pageNumber: pageNumber ?? this.pageNumber,
            numberOfResultsPerPage: numberOfResultsPerPage ?? this.numberOfResultsPerPage,
            pageSize: pageSize ?? this.pageSize,
            requireAllWords: requireAllWords ?? this.requireAllWords,
        );

    factory FoodSearchCriteria.fromMap(Map<String, dynamic> json) => FoodSearchCriteria(
        query: json["query"],
        generalSearchInput: json["generalSearchInput"],
        pageNumber: json["pageNumber"],
        numberOfResultsPerPage: json["numberOfResultsPerPage"],
        pageSize: json["pageSize"],
        requireAllWords: json["requireAllWords"],
    );

    Map<String, dynamic> toMap() => {
        "query": query,
        "generalSearchInput": generalSearchInput,
        "pageNumber": pageNumber,
        "numberOfResultsPerPage": numberOfResultsPerPage,
        "pageSize": pageSize,
        "requireAllWords": requireAllWords,
    };
}

class Food {
    Food({
        this.fdcId,
        this.description,
        this.lowercaseDescription,
        this.commonNames,
        this.additionalDescriptions,
        this.dataType,
        this.foodCode,
        this.publishedDate,
        this.foodCategory,
        this.foodCategoryId,
        this.allHighlightFields,
        this.score,
        this.microbes,
        this.foodNutrients,
        this.finalFoodInputFoods,
        this.foodMeasures,
        this.foodAttributes,
        this.foodAttributeTypes,
        this.foodVersionIds,
        this.gtinUpc,
        this.brandOwner,
        this.ingredients,
        this.marketCountry,
        this.modifiedDate,
        this.dataSource,
        this.servingSizeUnit,
        this.servingSize,
        this.householdServingFullText,
        this.tradeChannels,
        this.brandName,
        this.packageWeight,
        this.ndbNumber,
        this.shortDescription,
        this.subbrandName,
    });

    int? fdcId;
    String? description;
    String? lowercaseDescription;
    String? commonNames;
    String? additionalDescriptions;
    String? dataType;
    int? foodCode;
    DateTime? publishedDate;
    String? foodCategory;
    int? foodCategoryId;
    String? allHighlightFields;
    double? score;
    List<dynamic>? microbes;
    List<FoodNutrient>? foodNutrients;
    List<FinalFoodInputFood>? finalFoodInputFoods;
    List<FoodMeasure>? foodMeasures;
    List<dynamic>? foodAttributes;
    List<FoodAttributeType>? foodAttributeTypes;
    List<dynamic>? foodVersionIds;
    String? gtinUpc;
    String? brandOwner;
    String? ingredients;
    String? marketCountry;
    DateTime? modifiedDate;
    String? dataSource;
    String? servingSizeUnit;
    double? servingSize;
    String? householdServingFullText;
    List<String>? tradeChannels;
    String? brandName;
    String? packageWeight;
    int? ndbNumber;
    String? shortDescription;
    String? subbrandName;

    Food copyWith({
        int? fdcId,
        String? description,
        String? lowercaseDescription,
        String? commonNames,
        String? additionalDescriptions,
        String? dataType,
        int? foodCode,
        DateTime? publishedDate,
        String? foodCategory,
        int? foodCategoryId,
        String? allHighlightFields,
        double? score,
        List<dynamic>? microbes,
        List<FoodNutrient>? foodNutrients,
        List<FinalFoodInputFood>? finalFoodInputFoods,
        List<FoodMeasure>? foodMeasures,
        List<dynamic>? foodAttributes,
        List<FoodAttributeType>? foodAttributeTypes,
        List<dynamic>? foodVersionIds,
        String? gtinUpc,
        String? brandOwner,
        String? ingredients,
        String? marketCountry,
        DateTime? modifiedDate,
        String? dataSource,
        String? servingSizeUnit,
        double? servingSize,
        String? householdServingFullText,
        List<String>? tradeChannels,
        String? brandName,
        String? packageWeight,
        int? ndbNumber,
        String? shortDescription,
        String? subbrandName,
    }) => 
        Food(
            fdcId: fdcId ?? this.fdcId,
            description: description ?? this.description,
            lowercaseDescription: lowercaseDescription ?? this.lowercaseDescription,
            commonNames: commonNames ?? this.commonNames,
            additionalDescriptions: additionalDescriptions ?? this.additionalDescriptions,
            dataType: dataType ?? this.dataType,
            foodCode: foodCode ?? this.foodCode,
            publishedDate: publishedDate ?? this.publishedDate,
            foodCategory: foodCategory ?? this.foodCategory,
            foodCategoryId: foodCategoryId ?? this.foodCategoryId,
            allHighlightFields: allHighlightFields ?? this.allHighlightFields,
            score: score ?? this.score,
            microbes: microbes ?? this.microbes,
            foodNutrients: foodNutrients ?? this.foodNutrients,
            finalFoodInputFoods: finalFoodInputFoods ?? this.finalFoodInputFoods,
            foodMeasures: foodMeasures ?? this.foodMeasures,
            foodAttributes: foodAttributes ?? this.foodAttributes,
            foodAttributeTypes: foodAttributeTypes ?? this.foodAttributeTypes,
            foodVersionIds: foodVersionIds ?? this.foodVersionIds,
            gtinUpc: gtinUpc ?? this.gtinUpc,
            brandOwner: brandOwner ?? this.brandOwner,
            ingredients: ingredients ?? this.ingredients,
            marketCountry: marketCountry ?? this.marketCountry,
            modifiedDate: modifiedDate ?? this.modifiedDate,
            dataSource: dataSource ?? this.dataSource,
            servingSizeUnit: servingSizeUnit ?? this.servingSizeUnit,
            servingSize: servingSize ?? this.servingSize,
            householdServingFullText: householdServingFullText ?? this.householdServingFullText,
            tradeChannels: tradeChannels ?? this.tradeChannels,
            brandName: brandName ?? this.brandName,
            packageWeight: packageWeight ?? this.packageWeight,
            ndbNumber: ndbNumber ?? this.ndbNumber,
            shortDescription: shortDescription ?? this.shortDescription,
            subbrandName: subbrandName ?? this.subbrandName,
        );

    factory Food.fromMap(Map<String, dynamic> json) => Food(
        fdcId: json["fdcId"],
        description: json["description"],
        lowercaseDescription: json["lowercaseDescription"],
        commonNames: json["commonNames"],
        additionalDescriptions: json["additionalDescriptions"],
        dataType: json["dataType"],
        foodCode: json["foodCode"],
        publishedDate: json["publishedDate"] == null ? null : DateTime.parse(json["publishedDate"]),
        foodCategory: json["foodCategory"],
        foodCategoryId: json["foodCategoryId"],
        allHighlightFields: json["allHighlightFields"],
        score: json["score"]?.toDouble(),
        microbes: json["microbes"] == null ? [] : List<dynamic>.from(json["microbes"]!.map((x) => x)),
        foodNutrients: json["foodNutrients"] == null ? [] : List<FoodNutrient>.from(json["foodNutrients"]!.map((x) => FoodNutrient.fromMap(x))),
        finalFoodInputFoods: json["finalFoodInputFoods"] == null ? [] : List<FinalFoodInputFood>.from(json["finalFoodInputFoods"]!.map((x) => FinalFoodInputFood.fromMap(x))),
        foodMeasures: json["foodMeasures"] == null ? [] : List<FoodMeasure>.from(json["foodMeasures"]!.map((x) => FoodMeasure.fromMap(x))),
        foodAttributes: json["foodAttributes"] == null ? [] : List<dynamic>.from(json["foodAttributes"]!.map((x) => x)),
        foodAttributeTypes: json["foodAttributeTypes"] == null ? [] : List<FoodAttributeType>.from(json["foodAttributeTypes"]!.map((x) => FoodAttributeType.fromMap(x))),
        foodVersionIds: json["foodVersionIds"] == null ? [] : List<dynamic>.from(json["foodVersionIds"]!.map((x) => x)),
        gtinUpc: json["gtinUpc"],
        brandOwner: json["brandOwner"],
        ingredients: json["ingredients"],
        marketCountry: json["marketCountry"],
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
        dataSource: json["dataSource"],
        servingSizeUnit: json["servingSizeUnit"],
        servingSize: json["servingSize"]?.toDouble(),
        householdServingFullText: json["householdServingFullText"],
        tradeChannels: json["tradeChannels"] == null ? [] : List<String>.from(json["tradeChannels"]!.map((x) => x)),
        brandName: json["brandName"],
        packageWeight: json["packageWeight"],
        ndbNumber: json["ndbNumber"],
        shortDescription: json["shortDescription"],
        subbrandName: json["subbrandName"],
    );

    Map<String, dynamic> toMap() => {
        "fdcId": fdcId,
        "description": description,
        "lowercaseDescription": lowercaseDescription,
        "commonNames": commonNames,
        "additionalDescriptions": additionalDescriptions,
        "dataType": dataType,
        "foodCode": foodCode,
        "publishedDate": "${publishedDate!.year.toString().padLeft(4, '0')}-${publishedDate!.month.toString().padLeft(2, '0')}-${publishedDate!.day.toString().padLeft(2, '0')}",
        "foodCategory": foodCategory,
        "foodCategoryId": foodCategoryId,
        "allHighlightFields": allHighlightFields,
        "score": score,
        "microbes": microbes == null ? [] : List<dynamic>.from(microbes!.map((x) => x)),
        "foodNutrients": foodNutrients == null ? [] : List<dynamic>.from(foodNutrients!.map((x) => x.toMap())),
        "finalFoodInputFoods": finalFoodInputFoods == null ? [] : List<dynamic>.from(finalFoodInputFoods!.map((x) => x.toMap())),
        "foodMeasures": foodMeasures == null ? [] : List<dynamic>.from(foodMeasures!.map((x) => x.toMap())),
        "foodAttributes": foodAttributes == null ? [] : List<dynamic>.from(foodAttributes!.map((x) => x)),
        "foodAttributeTypes": foodAttributeTypes == null ? [] : List<dynamic>.from(foodAttributeTypes!.map((x) => x.toMap())),
        "foodVersionIds": foodVersionIds == null ? [] : List<dynamic>.from(foodVersionIds!.map((x) => x)),
        "gtinUpc": gtinUpc,
        "brandOwner": brandOwner,
        "ingredients": ingredients,
        "marketCountry": marketCountry,
        "modifiedDate": "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "dataSource": dataSource,
        "servingSizeUnit": servingSizeUnit,
        "servingSize": servingSize,
        "householdServingFullText": householdServingFullText,
        "tradeChannels": tradeChannels == null ? [] : List<dynamic>.from(tradeChannels!.map((x) => x)),
        "brandName": brandName,
        "packageWeight": packageWeight,
        "ndbNumber": ndbNumber,
        "shortDescription": shortDescription,
        "subbrandName": subbrandName,
    };
}

class FinalFoodInputFood {
    FinalFoodInputFood({
        this.foodDescription,
        this.gramWeight,
        this.id,
        this.portionCode,
        this.portionDescription,
        this.unit,
        this.rank,
        this.srCode,
        this.value,
    });

    String? foodDescription;
    double? gramWeight;
    int? id;
    String? portionCode;
    String? portionDescription;
    String? unit;
    int? rank;
    int? srCode;
    double? value;

    FinalFoodInputFood copyWith({
        String? foodDescription,
        double? gramWeight,
        int? id,
        String? portionCode,
        String? portionDescription,
        String? unit,
        int? rank,
        int? srCode,
        double? value,
    }) => 
        FinalFoodInputFood(
            foodDescription: foodDescription ?? this.foodDescription,
            gramWeight: gramWeight ?? this.gramWeight,
            id: id ?? this.id,
            portionCode: portionCode ?? this.portionCode,
            portionDescription: portionDescription ?? this.portionDescription,
            unit: unit ?? this.unit,
            rank: rank ?? this.rank,
            srCode: srCode ?? this.srCode,
            value: value ?? this.value,
        );

    factory FinalFoodInputFood.fromMap(Map<String, dynamic> json) => FinalFoodInputFood(
        foodDescription: json["foodDescription"],
        gramWeight: json["gramWeight"]?.toDouble(),
        id: json["id"],
        portionCode: json["portionCode"],
        portionDescription: json["portionDescription"],
        unit: json["unit"],
        rank: json["rank"],
        srCode: json["srCode"],
        value: json["value"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "foodDescription": foodDescription,
        "gramWeight": gramWeight,
        "id": id,
        "portionCode": portionCode,
        "portionDescription": portionDescription,
        "unit": unit,
        "rank": rank,
        "srCode": srCode,
        "value": value,
    };
}

class FoodAttributeType {
    FoodAttributeType({
        this.name,
        this.description,
        this.id,
        this.foodAttributes,
    });

    String? name;
    String? description;
    int? id;
    List<FoodAttribute>? foodAttributes;

    FoodAttributeType copyWith({
        String? name,
        String? description,
        int? id,
        List<FoodAttribute>? foodAttributes,
    }) => 
        FoodAttributeType(
            name: name ?? this.name,
            description: description ?? this.description,
            id: id ?? this.id,
            foodAttributes: foodAttributes ?? this.foodAttributes,
        );

    factory FoodAttributeType.fromMap(Map<String, dynamic> json) => FoodAttributeType(
        name: json["name"],
        description: json["description"],
        id: json["id"],
        foodAttributes: json["foodAttributes"] == null ? [] : List<FoodAttribute>.from(json["foodAttributes"]!.map((x) => FoodAttribute.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "id": id,
        "foodAttributes": foodAttributes == null ? [] : List<dynamic>.from(foodAttributes!.map((x) => x.toMap())),
    };
}

class FoodAttribute {
    FoodAttribute({
        this.value,
        this.id,
        this.sequenceNumber,
        this.name,
    });

    String? value;
    int? id;
    int? sequenceNumber;
    String? name;

    FoodAttribute copyWith({
        String? value,
        int? id,
        int? sequenceNumber,
        String? name,
    }) => 
        FoodAttribute(
            value: value ?? this.value,
            id: id ?? this.id,
            sequenceNumber: sequenceNumber ?? this.sequenceNumber,
            name: name ?? this.name,
        );

    factory FoodAttribute.fromMap(Map<String, dynamic> json) => FoodAttribute(
        value: json["value"],
        id: json["id"],
        sequenceNumber: json["sequenceNumber"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "value": value,
        "id": id,
        "sequenceNumber": sequenceNumber,
        "name": name,
    };
}

class FoodMeasure {
    FoodMeasure({
        this.disseminationText,
        this.gramWeight,
        this.id,
        this.modifier,
        this.rank,
        this.measureUnitAbbreviation,
        this.measureUnitName,
        this.measureUnitId,
    });

    String? disseminationText;
    num? gramWeight;
    int? id;
    String? modifier;
    int? rank;
    String? measureUnitAbbreviation;
    String? measureUnitName;
    int? measureUnitId;

    FoodMeasure copyWith({
        String? disseminationText,
        num? gramWeight,
        int? id,
        String? modifier,
        int? rank,
        String? measureUnitAbbreviation,
        String? measureUnitName,
        int? measureUnitId,
    }) => 
        FoodMeasure(
            disseminationText: disseminationText ?? this.disseminationText,
            gramWeight: gramWeight ?? this.gramWeight,
            id: id ?? this.id,
            modifier: modifier ?? this.modifier,
            rank: rank ?? this.rank,
            measureUnitAbbreviation: measureUnitAbbreviation ?? this.measureUnitAbbreviation,
            measureUnitName: measureUnitName ?? this.measureUnitName,
            measureUnitId: measureUnitId ?? this.measureUnitId,
        );

    factory FoodMeasure.fromMap(Map<String, dynamic> json) => FoodMeasure(
        disseminationText: json["disseminationText"],
        gramWeight: json["gramWeight"],
        id: json["id"],
        modifier: json["modifier"],
        rank: json["rank"],
        measureUnitAbbreviation: json["measureUnitAbbreviation"],
        measureUnitName: json["measureUnitName"],
        measureUnitId: json["measureUnitId"],
    );

    Map<String, dynamic> toMap() => {
        "disseminationText": disseminationText,
        "gramWeight": gramWeight,
        "id": id,
        "modifier": modifier,
        "rank": rank,
        "measureUnitAbbreviation": measureUnitAbbreviation,
        "measureUnitName": measureUnitName,
        "measureUnitId": measureUnitId,
    };
}

class FoodNutrient {
    FoodNutrient({
        this.nutrientId,
        this.nutrientName,
        this.nutrientNumber,
        this.unitName,
        this.value,
        this.rank,
        this.indentLevel,
        this.foodNutrientId,
        this.derivationCode,
        this.derivationDescription,
        this.derivationId,
        this.foodNutrientSourceId,
        this.foodNutrientSourceCode,
        this.foodNutrientSourceDescription,
        this.percentDailyValue,
        this.dataPoints,
    });

    int? nutrientId;
    String? nutrientName;
    String? nutrientNumber;
    String? unitName;
    double? value;
    int? rank;
    int? indentLevel;
    int? foodNutrientId;
    String? derivationCode;
    String? derivationDescription;
    int? derivationId;
    int? foodNutrientSourceId;
    String? foodNutrientSourceCode;
    String? foodNutrientSourceDescription;
    num? percentDailyValue;
    int? dataPoints;

    FoodNutrient copyWith({
        int? nutrientId,
        String? nutrientName,
        String? nutrientNumber,
        String? unitName,
        double? value,
        int? rank,
        int? indentLevel,
        int? foodNutrientId,
        String? derivationCode,
        String? derivationDescription,
        int? derivationId,
        int? foodNutrientSourceId,
        String? foodNutrientSourceCode,
        String? foodNutrientSourceDescription,
        num? percentDailyValue,
        int? dataPoints,
    }) => 
        FoodNutrient(
            nutrientId: nutrientId ?? this.nutrientId,
            nutrientName: nutrientName ?? this.nutrientName,
            nutrientNumber: nutrientNumber ?? this.nutrientNumber,
            unitName: unitName ?? this.unitName,
            value: value ?? this.value,
            rank: rank ?? this.rank,
            indentLevel: indentLevel ?? this.indentLevel,
            foodNutrientId: foodNutrientId ?? this.foodNutrientId,
            derivationCode: derivationCode ?? this.derivationCode,
            derivationDescription: derivationDescription ?? this.derivationDescription,
            derivationId: derivationId ?? this.derivationId,
            foodNutrientSourceId: foodNutrientSourceId ?? this.foodNutrientSourceId,
            foodNutrientSourceCode: foodNutrientSourceCode ?? this.foodNutrientSourceCode,
            foodNutrientSourceDescription: foodNutrientSourceDescription ?? this.foodNutrientSourceDescription,
            percentDailyValue: percentDailyValue ?? this.percentDailyValue,
            dataPoints: dataPoints ?? this.dataPoints,
        );

    factory FoodNutrient.fromMap(Map<String, dynamic> json) => FoodNutrient(
        nutrientId: json["nutrientId"],
        nutrientName: json["nutrientName"],
        nutrientNumber: json["nutrientNumber"],
        unitName: json["unitName"],
        value: json["value"]?.toDouble(),
        rank: json["rank"],
        indentLevel: json["indentLevel"],
        foodNutrientId: json["foodNutrientId"],
        derivationCode: json["derivationCode"],
        derivationDescription: json["derivationDescription"],
        derivationId: json["derivationId"],
        foodNutrientSourceId: json["foodNutrientSourceId"],
        foodNutrientSourceCode: json["foodNutrientSourceCode"],
        foodNutrientSourceDescription: json["foodNutrientSourceDescription"],
        percentDailyValue: json["percentDailyValue"],
        dataPoints: json["dataPoints"],
    );

    Map<String, dynamic> toMap() => {
        "nutrientId": nutrientId,
        "nutrientName": nutrientName,
        "nutrientNumber": nutrientNumber,
        "unitName": unitName,
        "value": value,
        "rank": rank,
        "indentLevel": indentLevel,
        "foodNutrientId": foodNutrientId,
        "derivationCode": derivationCode,
        "derivationDescription": derivationDescription,
        "derivationId": derivationId,
        "foodNutrientSourceId": foodNutrientSourceId,
        "foodNutrientSourceCode": foodNutrientSourceCode,
        "foodNutrientSourceDescription": foodNutrientSourceDescription,
        "percentDailyValue": percentDailyValue,
        "dataPoints": dataPoints,
    };
}
