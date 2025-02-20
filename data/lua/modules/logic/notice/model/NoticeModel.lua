module("modules.logic.notice.model.NoticeModel", package.seeall)

slot0 = class("NoticeModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._beforeloginNotices = {}
	slot0._norNotices = {}
	slot0._noticeUrl = {}
	slot0._hasOpenNoticeIdDict = {}
	slot0._hasOpenNoticeCount = 0
	slot0._cacheAssetItems = {}
	slot0._cacheSprite = {}
	slot0._cacheSpriteDefaultSize = {}
	slot0._loadedSpriteDict = {}
	slot0._loadingSprites = {}
	slot0._loadingSpriteCount = 0
	slot0._needLoadUrlList = {}
	slot0._loadTaskList = {}

	for slot6, slot7 in ipairs(string.splitToNumber(PlayerPrefsHelper.getString(PlayerPrefsKey.NoticeAutoOpenIds, ""), "#")) do
		slot0._hasOpenNoticeIdDict[slot7] = true
	end

	slot0._hasOpenNoticeCount = #slot2
	slot0._selectType = nil

	slot0:initRedDot()
end

function slot0.initRedDot(slot0)
	slot0.redDotDict = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.NoticeRedDotKey, nil)) then
		slot6 = slot1

		for slot5, slot6 in ipairs(string.split(slot6, ";")) do
			slot0.redDotDict[slot6] = true
		end
	end
end

function slot0.buildRedDotKey(slot0, slot1)
	if not slot1 then
		logWarn("noticeMo is nil")

		return nil
	end

	return tostring(slot1.gameId) .. tostring(slot1.id)
end

function slot0.readNoticeMo(slot0, slot1)
	if not slot0:buildRedDotKey(slot1) then
		return
	end

	if slot0.redDotDict[slot2] then
		return
	end

	slot0.redDotDict[slot2] = true

	for slot7, slot8 in pairs(slot0.redDotDict) do
		slot3 = "" .. slot7 .. ";"
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.NoticeRedDotKey, string.gsub(slot3, ";$", ""))
	NoticeController.instance:dispatchEvent(NoticeEvent.OnRefreshRedDot)
end

function slot0.getNoticeMoIsRead(slot0, slot1)
	return slot0:buildRedDotKey(slot1) and slot0.redDotDict[slot2]
end

function slot0.getNoticeTypeIsRead(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._norNotices) do
		if ServerTime.now() > slot7.beginTime / 1000 and slot8 < slot7.endTime / 1000 then
			for slot12, slot13 in pairs(slot7.noticeTypes) do
				if slot1 == slot13 then
					table.insert(slot2, slot7)
				end
			end
		end
	end

	if #slot2 == 0 then
		return true
	end

	for slot6, slot7 in ipairs(slot2) do
		if not slot0:getNoticeMoIsRead(slot7) then
			return false
		end
	end

	return true
end

function slot0.hasNotRedNotice(slot0)
	for slot4, slot5 in ipairs(slot0._norNotices) do
		if slot5:isNormalStatus() and not slot0:getNoticeMoIsRead(slot5) then
			return true
		end
	end

	return false
end

function slot0.onGetInfo(slot0, slot1)
	slot0._beforeloginNotices = {}
	slot0._norNotices = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.noticePositionTypes and next(slot6.noticePositionTypes) then
			slot11 = slot6

			NoticeMO.New():init(slot11)

			for slot11, slot12 in pairs(slot6.noticePositionTypes) do
				if slot12 == NoticeEnum.NoticePositionType.BeforeLogin then
					table.insert(slot0._beforeloginNotices, slot7)
				elseif slot12 == NoticeEnum.NoticePositionType.InGame then
					table.insert(slot0._norNotices, slot7)
				end
			end
		end
	end
end

function slot0.checkNoticeOnlyIncludeType(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot1.noticeTypes and #slot1.noticeTypes > 1 then
		return false
	end

	return slot1.noticeTypes and slot1.noticeTypes[1] == slot2
end

function slot0.hadNewNotice(slot0)
	for slot5, slot6 in ipairs(slot0._norNotices) do
		if not slot0._hasOpenNoticeIdDict[slot6.id] then
			return true
		end
	end

	return false
end

function slot0.onOpenNoticeView(slot0)
	for slot5, slot6 in ipairs(slot0._norNotices) do
		slot0._hasOpenNoticeIdDict[slot6.id] = true
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0._hasOpenNoticeIdDict) do
		table.insert(slot2, slot6)
	end

	if slot0._hasOpenNoticeCount < #slot2 then
		PlayerPrefsHelper.setString(PlayerPrefsKey.NoticeAutoOpenIds, table.concat(slot2, "#"))
	end

	slot0._hasOpenNoticeCount = 999999999
end

function slot0.addTestNoticeMO(slot0, slot1)
	table.insert(slot0._norNotices, slot1)
end

function slot0.getNoticesByType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._norNotices) do
		if ServerTime.now() > slot7.beginTime / 1000 and slot8 < slot7.endTime / 1000 then
			if slot1 == NoticeType.All then
				table.insert(slot2, slot7)
			else
				for slot12, slot13 in pairs(slot7.noticeTypes) do
					if slot1 == slot13 then
						table.insert(slot2, slot7)
					end
				end
			end
		end
	end

	return slot2
end

function slot0.getSelectType(slot0)
	return slot0._selectType and slot0._selectType or 1
end

function slot0.setSelectType(slot0, slot1)
	slot0._selectType = slot1
end

function slot0.resetSelectType(slot0)
	slot0._selectType = nil
end

function slot0.setAutoSelectType(slot0, slot1)
	slot0.autoSelectType = slot1
end

function slot0.switchNoticeTypeByToggleId(slot0, slot1)
	slot0:switchNoticeType(NoticeType.NoticeList[slot1])
end

function slot0.switchNoticeType(slot0, slot1)
	slot0:setSelectType(slot1 or NoticeType.All)
	slot0:resetLastSelectIndex()

	slot2 = {}

	for slot6, slot7 in ipairs(slot0._norNotices) do
		if ServerTime.now() > slot7.beginTime / 1000 and slot8 < slot7.endTime / 1000 then
			if slot1 == NoticeType.All then
				table.insert(slot2, slot7)
			else
				for slot12, slot13 in pairs(slot7.noticeTypes) do
					if slot1 == slot13 then
						table.insert(slot2, slot7)
					end
				end
			end
		end
	end

	table.sort(slot2, function (slot0, slot1)
		if slot0.isTop ~= slot1.isTop then
			return slot1.isTop < slot0.isTop
		end

		if slot0.order ~= slot1.order then
			return slot1.order < slot0.order
		end

		return slot1.id < slot0.id
	end)
	slot0:setList(slot2)
end

function slot0.getNextUrlId(slot0)
	return #slot0._noticeUrl + 1
end

function slot0.setNoticeUrl(slot0, slot1, slot2)
	slot0._noticeUrl[slot1] = slot2
end

function slot0.getNoticeUrl(slot0, slot1)
	return slot0._noticeUrl[slot1]
end

function slot0.hasBeforeLoginNotice(slot0)
	return slot0._beforeloginNotices and next(slot0._beforeloginNotices)
end

function slot0.getBeforeLoginNoticeContent(slot0)
	return slot0._beforeloginNotices[1]:getContent()
end

function slot0.getBeforeLoginNoticeTitle(slot0)
	return slot0._beforeloginNotices[1]:getTitle()
end

function slot0.resetLastSelectIndex(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5.lastSelectIndex = -1
	end
end

function slot0.getSpriteCache(slot0, slot1)
	return slot0._cacheSprite[slot1]
end

function slot0.setSpriteCache(slot0, slot1, slot2)
	slot0._cacheSprite[slot1] = slot2
end

function slot0.setLoadedSprite(slot0, slot1)
	slot0._loadedSpriteDict[slot1] = true
end

function slot0.isLoaded(slot0, slot1)
	return slot0._loadedSpriteDict[slot1]
end

function slot0.getSpriteCacheDefaultSize(slot0, slot1)
	if string.nilorempty(slot0._cacheSpriteDefaultSize[slot1]) then
		return nil, 
	end

	slot3 = string.splitToNumber(slot2, "*")

	return slot3[1], slot3[2]
end

function slot0.setSpriteCacheDefaultSize(slot0, slot1, slot2, slot3)
	if NoticeEnum.IMGMaxWidth < slot2 then
		slot3 = slot3 / slot2 * NoticeEnum.IMGMaxWidth
		slot2 = NoticeEnum.IMGMaxWidth
	end

	slot0._cacheSpriteDefaultSize[slot1] = string.format("%d*%d", slot2, slot3)
end

function slot0.filenameInLoadingSprite(slot0, slot1)
	return slot0._loadingSprites[slot1] ~= nil
end

function slot0.addLoadingSprite(slot0, slot1)
	slot0._loadingSprites[slot1] = true
	slot0._loadingSpriteCount = slot0._loadingSpriteCount + 1
end

function slot0.removeLoadingSpriteCount(slot0, slot1)
	slot0._loadingSprites[slot1] = nil
	slot0._loadingSpriteCount = slot0._loadingSpriteCount - 1
end

function slot0.getLoadingSpriteCount(slot0)
	return slot0._loadingSpriteCount
end

function slot0.addAssetItem(slot0, slot1)
	table.insert(slot0._cacheAssetItems, 1, slot1)
end

function slot0.addNeedLoadImageUrl(slot0, slot1)
	table.insert(slot0._needLoadUrlList, slot1)
end

function slot0.popNeedLoadImageUrl(slot0)
	return table.remove(slot0._needLoadUrlList)
end

function slot0.addLoadTask(slot0, slot1, slot2)
	table.insert(slot0._loadTaskList, {
		slot1,
		slot2
	})
end

function slot0.removeLoadTask(slot0, slot1, slot2)
	slot3 = 0

	for slot7, slot8 in ipairs(slot0._loadTaskList) do
		if slot8[2] == slot2 and slot8[1] == slot1 then
			slot3 = slot7

			break
		end
	end

	table.remove(slot0._loadTaskList, slot3)
end

function slot0.onCloseNoticeView(slot0)
	slot0:clear()
	NoticeContentListModel.instance:clear()

	slot4 = nil

	slot0:setSelectType(slot4)

	for slot4, slot5 in ipairs(slot0._loadTaskList) do
		TaskDispatcher.cancelTask(slot5[1], slot5[2])
	end

	for slot4, slot5 in ipairs(slot0._cacheSprite) do
		gohelper.destroy(slot5)
	end

	for slot4, slot5 in ipairs(slot0._cacheAssetItems) do
		slot5:Release()
	end

	slot0._cacheSprite = {}
	slot0._cacheAssetItems = {}
	slot0._cacheSpriteDefaultSize = {}
	slot0._loadedSpriteDict = {}
	slot0._loadingSprites = {}
	slot0._loadingSpriteCount = 0
	slot0._needLoadUrlList = {}
	slot0._loadTaskList = {}
end

function slot0.canAutoOpen(slot0)
	if not slot0:hadNewNotice() then
		return false
	end

	slot0:_initConstConfig()

	if not GameUtil.splitString2(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.NoticePatKey), ""), true, NoticeEnum.SecondSplitChar, NoticeEnum.FirstSplitChar) or #slot3 < slot0.configOpenCount then
		return true
	end

	slot5 = os.date("*t", ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond)
	slot6 = slot5.year
	slot7 = slot5.month
	slot8 = slot5.day
	slot10 = 0

	while slot5.hour >= slot10 + slot0.configTimeInterval do
		slot10 = slot10 + slot0.configTimeInterval
	end

	slot11 = {}

	for slot16, slot17 in ipairs(slot3) do
		slot19 = slot17[2]
		slot20, slot21 = nil

		if slot17[1] == slot6 and slot19 == slot7 and slot20 == slot8 and slot10 <= slot21 then
			slot12 = 0 + 1

			table.insert(slot11, string.format("%s%s%s%s%s%s%s", slot18, NoticeEnum.FirstSplitChar, slot19, NoticeEnum.FirstSplitChar, slot20, NoticeEnum.FirstSplitChar, slot21))
		end
	end

	PlayerPrefsHelper.setString(slot1, table.concat(slot11, NoticeEnum.SecondSplitChar))

	return slot12 < slot0.configOpenCount
end

function slot0._initConstConfig(slot0)
	if slot0.configTimeInterval then
		return
	end

	slot2 = string.splitToNumber(lua_const.configDict[150].value, "#")
	slot0.configOpenCount = slot2[2]
	slot0.configTimeInterval = slot2[1]
end

slot0.instance = slot0.New()

return slot0
