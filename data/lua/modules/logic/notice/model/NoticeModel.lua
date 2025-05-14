module("modules.logic.notice.model.NoticeModel", package.seeall)

local var_0_0 = class("NoticeModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._beforeloginNotices = {}
	arg_1_0._norNotices = {}
	arg_1_0._noticeUrl = {}
	arg_1_0._hasOpenNoticeIdDict = {}
	arg_1_0._hasOpenNoticeCount = 0
	arg_1_0._cacheAssetItems = {}
	arg_1_0._cacheSprite = {}
	arg_1_0._cacheSpriteDefaultSize = {}
	arg_1_0._loadedSpriteDict = {}
	arg_1_0._loadingSprites = {}
	arg_1_0._loadingSpriteCount = 0
	arg_1_0._needLoadUrlList = {}
	arg_1_0._loadTaskList = {}

	local var_1_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.NoticeAutoOpenIds, "")
	local var_1_1 = string.splitToNumber(var_1_0, "#")

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		arg_1_0._hasOpenNoticeIdDict[iter_1_1] = true
	end

	arg_1_0._hasOpenNoticeCount = #var_1_1
	arg_1_0._selectType = nil

	arg_1_0:initRedDot()
end

function var_0_0.initRedDot(arg_2_0)
	arg_2_0.redDotDict = {}

	local var_2_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.NoticeRedDotKey, nil)

	if not string.nilorempty(var_2_0) then
		for iter_2_0, iter_2_1 in ipairs(string.split(var_2_0, ";")) do
			arg_2_0.redDotDict[iter_2_1] = true
		end
	end
end

function var_0_0.buildRedDotKey(arg_3_0, arg_3_1)
	if not arg_3_1 then
		logWarn("noticeMo is nil")

		return nil
	end

	return tostring(arg_3_1.gameId) .. tostring(arg_3_1.id)
end

function var_0_0.readNoticeMo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:buildRedDotKey(arg_4_1)

	if not var_4_0 then
		return
	end

	if arg_4_0.redDotDict[var_4_0] then
		return
	end

	arg_4_0.redDotDict[var_4_0] = true

	local var_4_1 = ""

	for iter_4_0, iter_4_1 in pairs(arg_4_0.redDotDict) do
		var_4_1 = var_4_1 .. iter_4_0 .. ";"
	end

	local var_4_2 = string.gsub(var_4_1, ";$", "")

	PlayerPrefsHelper.setString(PlayerPrefsKey.NoticeRedDotKey, var_4_2)
	NoticeController.instance:dispatchEvent(NoticeEvent.OnRefreshRedDot)
end

function var_0_0.getNoticeMoIsRead(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:buildRedDotKey(arg_5_1)

	return var_5_0 and arg_5_0.redDotDict[var_5_0]
end

function var_0_0.getNoticeTypeIsRead(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._norNotices) do
		local var_6_1 = ServerTime.now()

		if var_6_1 > iter_6_1.beginTime / 1000 and var_6_1 < iter_6_1.endTime / 1000 then
			for iter_6_2, iter_6_3 in pairs(iter_6_1.noticeTypes) do
				if arg_6_1 == iter_6_3 then
					table.insert(var_6_0, iter_6_1)
				end
			end
		end
	end

	if #var_6_0 == 0 then
		return true
	end

	for iter_6_4, iter_6_5 in ipairs(var_6_0) do
		if not arg_6_0:getNoticeMoIsRead(iter_6_5) then
			return false
		end
	end

	return true
end

function var_0_0.hasNotRedNotice(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._norNotices) do
		if iter_7_1:isNormalStatus() and not arg_7_0:getNoticeMoIsRead(iter_7_1) then
			return true
		end
	end

	return false
end

function var_0_0.onGetInfo(arg_8_0, arg_8_1)
	arg_8_0._beforeloginNotices = {}
	arg_8_0._norNotices = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if iter_8_1.noticePositionTypes and next(iter_8_1.noticePositionTypes) then
			local var_8_0 = NoticeMO.New()

			var_8_0:init(iter_8_1)

			for iter_8_2, iter_8_3 in pairs(iter_8_1.noticePositionTypes) do
				if iter_8_3 == NoticeEnum.NoticePositionType.BeforeLogin then
					table.insert(arg_8_0._beforeloginNotices, var_8_0)
				elseif iter_8_3 == NoticeEnum.NoticePositionType.InGame then
					table.insert(arg_8_0._norNotices, var_8_0)
				end
			end
		end
	end
end

function var_0_0.checkNoticeOnlyIncludeType(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	if arg_9_1.noticeTypes and #arg_9_1.noticeTypes > 1 then
		return false
	end

	return arg_9_1.noticeTypes and arg_9_1.noticeTypes[1] == arg_9_2
end

function var_0_0.hadNewNotice(arg_10_0)
	local var_10_0 = arg_10_0._norNotices

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if not arg_10_0._hasOpenNoticeIdDict[iter_10_1.id] then
			return true
		end
	end

	return false
end

function var_0_0.onOpenNoticeView(arg_11_0)
	local var_11_0 = arg_11_0._norNotices

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		arg_11_0._hasOpenNoticeIdDict[iter_11_1.id] = true
	end

	local var_11_1 = {}

	for iter_11_2, iter_11_3 in pairs(arg_11_0._hasOpenNoticeIdDict) do
		table.insert(var_11_1, iter_11_2)
	end

	if #var_11_1 > arg_11_0._hasOpenNoticeCount then
		PlayerPrefsHelper.setString(PlayerPrefsKey.NoticeAutoOpenIds, table.concat(var_11_1, "#"))
	end

	arg_11_0._hasOpenNoticeCount = 999999999
end

function var_0_0.addTestNoticeMO(arg_12_0, arg_12_1)
	table.insert(arg_12_0._norNotices, arg_12_1)
end

function var_0_0.getNoticesByType(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._norNotices) do
		local var_13_1 = ServerTime.now()

		if var_13_1 > iter_13_1.beginTime / 1000 and var_13_1 < iter_13_1.endTime / 1000 then
			if arg_13_1 == NoticeType.All then
				table.insert(var_13_0, iter_13_1)
			else
				for iter_13_2, iter_13_3 in pairs(iter_13_1.noticeTypes) do
					if arg_13_1 == iter_13_3 then
						table.insert(var_13_0, iter_13_1)
					end
				end
			end
		end
	end

	return var_13_0
end

function var_0_0.getSelectType(arg_14_0)
	return arg_14_0._selectType and arg_14_0._selectType or 1
end

function var_0_0.setSelectType(arg_15_0, arg_15_1)
	arg_15_0._selectType = arg_15_1
end

function var_0_0.resetSelectType(arg_16_0)
	arg_16_0._selectType = nil
end

function var_0_0.setAutoSelectType(arg_17_0, arg_17_1)
	arg_17_0.autoSelectType = arg_17_1
end

function var_0_0.switchNoticeTypeByToggleId(arg_18_0, arg_18_1)
	arg_18_0:switchNoticeType(NoticeType.NoticeList[arg_18_1])
end

function var_0_0.switchNoticeType(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or NoticeType.All

	arg_19_0:setSelectType(arg_19_1)
	arg_19_0:resetLastSelectIndex()

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._norNotices) do
		local var_19_1 = ServerTime.now()

		if var_19_1 > iter_19_1.beginTime / 1000 and var_19_1 < iter_19_1.endTime / 1000 then
			if arg_19_1 == NoticeType.All then
				table.insert(var_19_0, iter_19_1)
			else
				for iter_19_2, iter_19_3 in pairs(iter_19_1.noticeTypes) do
					if arg_19_1 == iter_19_3 then
						table.insert(var_19_0, iter_19_1)
					end
				end
			end
		end
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		if arg_20_0.isTop ~= arg_20_1.isTop then
			return arg_20_0.isTop > arg_20_1.isTop
		end

		if arg_20_0.order ~= arg_20_1.order then
			return arg_20_0.order > arg_20_1.order
		end

		return arg_20_0.id > arg_20_1.id
	end)
	arg_19_0:setList(var_19_0)
end

function var_0_0.getNextUrlId(arg_21_0)
	return #arg_21_0._noticeUrl + 1
end

function var_0_0.setNoticeUrl(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._noticeUrl[arg_22_1] = arg_22_2
end

function var_0_0.getNoticeUrl(arg_23_0, arg_23_1)
	return arg_23_0._noticeUrl[arg_23_1]
end

function var_0_0.hasBeforeLoginNotice(arg_24_0)
	return arg_24_0._beforeloginNotices and next(arg_24_0._beforeloginNotices)
end

function var_0_0.getBeforeLoginNoticeContent(arg_25_0)
	return arg_25_0._beforeloginNotices[1]:getContent()
end

function var_0_0.getBeforeLoginNoticeTitle(arg_26_0)
	return arg_26_0._beforeloginNotices[1]:getTitle()
end

function var_0_0.resetLastSelectIndex(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0._scrollViews) do
		iter_27_1.lastSelectIndex = -1
	end
end

function var_0_0.getSpriteCache(arg_28_0, arg_28_1)
	return arg_28_0._cacheSprite[arg_28_1]
end

function var_0_0.setSpriteCache(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0._cacheSprite[arg_29_1] = arg_29_2
end

function var_0_0.setLoadedSprite(arg_30_0, arg_30_1)
	arg_30_0._loadedSpriteDict[arg_30_1] = true
end

function var_0_0.isLoaded(arg_31_0, arg_31_1)
	return arg_31_0._loadedSpriteDict[arg_31_1]
end

function var_0_0.getSpriteCacheDefaultSize(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._cacheSpriteDefaultSize[arg_32_1]

	if string.nilorempty(var_32_0) then
		return nil, nil
	end

	local var_32_1 = string.splitToNumber(var_32_0, "*")

	return var_32_1[1], var_32_1[2]
end

function var_0_0.setSpriteCacheDefaultSize(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 > NoticeEnum.IMGMaxWidth then
		arg_33_3 = arg_33_3 / arg_33_2 * NoticeEnum.IMGMaxWidth
		arg_33_2 = NoticeEnum.IMGMaxWidth
	end

	arg_33_0._cacheSpriteDefaultSize[arg_33_1] = string.format("%d*%d", arg_33_2, arg_33_3)
end

function var_0_0.filenameInLoadingSprite(arg_34_0, arg_34_1)
	return arg_34_0._loadingSprites[arg_34_1] ~= nil
end

function var_0_0.addLoadingSprite(arg_35_0, arg_35_1)
	arg_35_0._loadingSprites[arg_35_1] = true
	arg_35_0._loadingSpriteCount = arg_35_0._loadingSpriteCount + 1
end

function var_0_0.removeLoadingSpriteCount(arg_36_0, arg_36_1)
	arg_36_0._loadingSprites[arg_36_1] = nil
	arg_36_0._loadingSpriteCount = arg_36_0._loadingSpriteCount - 1
end

function var_0_0.getLoadingSpriteCount(arg_37_0)
	return arg_37_0._loadingSpriteCount
end

function var_0_0.addAssetItem(arg_38_0, arg_38_1)
	table.insert(arg_38_0._cacheAssetItems, 1, arg_38_1)
end

function var_0_0.addNeedLoadImageUrl(arg_39_0, arg_39_1)
	table.insert(arg_39_0._needLoadUrlList, arg_39_1)
end

function var_0_0.popNeedLoadImageUrl(arg_40_0)
	return table.remove(arg_40_0._needLoadUrlList)
end

function var_0_0.addLoadTask(arg_41_0, arg_41_1, arg_41_2)
	table.insert(arg_41_0._loadTaskList, {
		arg_41_1,
		arg_41_2
	})
end

function var_0_0.removeLoadTask(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = 0

	for iter_42_0, iter_42_1 in ipairs(arg_42_0._loadTaskList) do
		if iter_42_1[2] == arg_42_2 and iter_42_1[1] == arg_42_1 then
			var_42_0 = iter_42_0

			break
		end
	end

	table.remove(arg_42_0._loadTaskList, var_42_0)
end

function var_0_0.onCloseNoticeView(arg_43_0)
	arg_43_0:clear()
	NoticeContentListModel.instance:clear()
	arg_43_0:setSelectType(nil)

	for iter_43_0, iter_43_1 in ipairs(arg_43_0._loadTaskList) do
		TaskDispatcher.cancelTask(iter_43_1[1], iter_43_1[2])
	end

	for iter_43_2, iter_43_3 in ipairs(arg_43_0._cacheSprite) do
		gohelper.destroy(iter_43_3)
	end

	for iter_43_4, iter_43_5 in ipairs(arg_43_0._cacheAssetItems) do
		iter_43_5:Release()
	end

	arg_43_0._cacheSprite = {}
	arg_43_0._cacheAssetItems = {}
	arg_43_0._cacheSpriteDefaultSize = {}
	arg_43_0._loadedSpriteDict = {}
	arg_43_0._loadingSprites = {}
	arg_43_0._loadingSpriteCount = 0
	arg_43_0._needLoadUrlList = {}
	arg_43_0._loadTaskList = {}
end

function var_0_0.canAutoOpen(arg_44_0)
	if not arg_44_0:hadNewNotice() then
		return false
	end

	arg_44_0:_initConstConfig()

	local var_44_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.NoticePatKey)
	local var_44_1 = PlayerPrefsHelper.getString(var_44_0, "")
	local var_44_2 = GameUtil.splitString2(var_44_1, true, NoticeEnum.SecondSplitChar, NoticeEnum.FirstSplitChar)

	if not var_44_2 or #var_44_2 < arg_44_0.configOpenCount then
		return true
	end

	local var_44_3 = ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local var_44_4 = os.date("*t", var_44_3)
	local var_44_5 = var_44_4.year
	local var_44_6 = var_44_4.month
	local var_44_7 = var_44_4.day
	local var_44_8 = var_44_4.hour
	local var_44_9 = 0

	while var_44_8 >= var_44_9 + arg_44_0.configTimeInterval do
		var_44_9 = var_44_9 + arg_44_0.configTimeInterval
	end

	local var_44_10 = {}
	local var_44_11 = 0

	for iter_44_0, iter_44_1 in ipairs(var_44_2) do
		local var_44_12 = iter_44_1[1]
		local var_44_13 = iter_44_1[2]
		local var_44_14
		local var_44_15

		if var_44_12 == var_44_5 and var_44_13 == var_44_6 and var_44_14 == var_44_7 and var_44_9 <= var_44_15 then
			var_44_11 = var_44_11 + 1

			table.insert(var_44_10, string.format("%s%s%s%s%s%s%s", var_44_12, NoticeEnum.FirstSplitChar, var_44_13, NoticeEnum.FirstSplitChar, var_44_14, NoticeEnum.FirstSplitChar, var_44_15))
		end
	end

	PlayerPrefsHelper.setString(var_44_0, table.concat(var_44_10, NoticeEnum.SecondSplitChar))

	return var_44_11 < arg_44_0.configOpenCount
end

function var_0_0._initConstConfig(arg_45_0)
	if arg_45_0.configTimeInterval then
		return
	end

	local var_45_0 = lua_const.configDict[150].value
	local var_45_1 = string.splitToNumber(var_45_0, "#")

	arg_45_0.configTimeInterval, arg_45_0.configOpenCount = var_45_1[1], var_45_1[2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
