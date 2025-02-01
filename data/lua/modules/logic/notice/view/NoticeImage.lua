module("modules.logic.notice.view.NoticeImage", package.seeall)

slot0 = class("NoticeImage", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._img = gohelper.onceAddComponent(slot0._go, gohelper.Type_Image)
	slot0._assetItem = nil
	slot0._cacheSprite = {}

	gohelper.setActive(slot0._go, false)
end

function slot0.load(slot0, slot1)
	gohelper.setActive(slot0._go, true)

	if NoticeModel.instance:isLoaded(slot0:getFilenameFormUrl(slot1)) then
		slot0._img.color = Color.white
		slot0._img.sprite = NoticeModel.instance:getSpriteCache(slot2)

		slot0:log("【load func】 load cache success , filename is : " .. slot2)

		return true
	end

	slot0:log("【load func】 load url is : " .. slot1)

	slot0._img.sprite = nil
	slot0._img.color = Color.clear

	if NoticeModel.instance:filenameInLoadingSprite(slot2) then
		slot0:log("【load func】 " .. slot2 .. "  loading return false,")

		return false
	end

	NoticeModel.instance:addLoadingSprite(slot2)
	NoticeModel.instance:addNeedLoadImageUrl(slot1)
	NoticeModel.instance:addLoadTask(slot0._load, slot0)
	TaskDispatcher.runDelay(slot0._load, slot0, 0.01)

	return false
end

function slot0._load(slot0)
	slot1 = NoticeModel.instance:popNeedLoadImageUrl()

	while slot1 do
		if SLFramework.FileHelper.IsFileExists(slot0:getNoticeImgFilePath("notice/" .. slot0:getFilenameFormUrl(slot1))) then
			loadPersistentRes(slot3, SLFramework.AssetType.TEXTURE, slot0._onLoadCallback, slot0)
		else
			ZProj.SLPictureDownloader.Instance:Download(slot1, slot0._downloadCallback, slot0)
		end

		slot1 = NoticeModel.instance:popNeedLoadImageUrl()
	end

	NoticeModel.instance:removeLoadTask(slot0._load, slot0)
end

function slot0.addLoadCallback(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
end

function slot0._onLoadCallback(slot0, slot1)
	NoticeModel.instance:setLoadedSprite(slot0:getFilenameFormUrl(slot1.ResPath))

	if slot1.IsLoadSuccess then
		slot1:Retain()

		slot3 = slot1:GetResource()

		NoticeModel.instance:setSpriteCache(slot2, UnityEngine.Sprite.Create(slot3, UnityEngine.Rect.New(0, 0, slot3.width, slot3.height), Vector2.zero, 100, 0))
		NoticeModel.instance:setSpriteCacheDefaultSize(slot2, slot3.width, slot3.height)
		NoticeModel.instance:addAssetItem(slot1)
		slot0:_doCallback(true, slot2)
	else
		logError("load fail: " .. slot1.ResPath)
		slot0:_doCallback(false, slot2)
	end
end

function slot0._downloadCallback(slot0, slot1, slot2, slot3, slot4)
	NoticeModel.instance:setLoadedSprite(slot0:getFilenameFormUrl(slot4))

	if slot1 then
		SLFramework.FileHelper.WriteAllBytesToPath(slot0:getNoticeImgFilePath("notice/" .. slot5), slot3)
		NoticeModel.instance:setSpriteCache(slot5, UnityEngine.Sprite.Create(slot2, UnityEngine.Rect.New(0, 0, slot2.width, slot2.height), Vector2.zero, 100, 0))
		NoticeModel.instance:setSpriteCacheDefaultSize(slot5, slot2.width, slot2.height)
		slot0:_doCallback(true, slot5)
	else
		logError("download fail: " .. slot4)
		slot0:_doCallback(false, slot5)
	end
end

function slot0._doCallback(slot0, slot1, slot2)
	if slot1 then
		slot0:log("【_doCallback func】 load success, self.filename is " .. slot2)
	else
		slot0:log("【_doCallback func】 load fail, self.filename is " .. slot2)
	end

	NoticeModel.instance:removeLoadingSpriteCount(slot2)

	if NoticeModel.instance:getLoadingSpriteCount() <= 0 then
		NoticeContentListModel.instance:onModelUpdate()
	end

	slot4 = slot0._callbackObj
	slot0._callback = nil
	slot0._callbackObj = nil

	if slot0._callback then
		if slot4 then
			slot3(slot4, slot1)
		else
			slot3(slot1)
		end
	end
end

function slot0.getNoticeImgFilePath(slot0, slot1)
	return SLFramework.FrameworkSettings.PersistentResRootDir .. "/" .. slot1
end

function slot0.getFilenameFormUrl(slot0, slot1)
	return SLFramework.FileHelper.GetFileName(string.gsub(slot1, "?.*", ""), true)
end

function slot0.log(slot0, slot1)
	logWarn(string.format("【NoticeImageLog】msg : %s", slot1))
end

return slot0
