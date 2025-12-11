module("modules.logic.notice.view.NoticeImage", package.seeall)

local var_0_0 = class("NoticeImage", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._img = gohelper.onceAddComponent(arg_1_0._go, gohelper.Type_Image)
	arg_1_0._assetItem = nil
	arg_1_0._cacheSprite = {}

	gohelper.setActive(arg_1_0._go, false)
end

function var_0_0.load(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getFilenameFormUrl(arg_2_1)

	gohelper.setActive(arg_2_0._go, true)

	if NoticeModel.instance:isLoaded(var_2_0) then
		arg_2_0._img.color = Color.white
		arg_2_0._img.sprite = NoticeModel.instance:getSpriteCache(var_2_0)

		arg_2_0:log("【load func】 load cache success , filename is : " .. var_2_0)

		return true
	end

	arg_2_0:log("【load func】 load url is : " .. arg_2_1)

	arg_2_0._img.sprite = nil
	arg_2_0._img.color = Color.clear

	if NoticeModel.instance:filenameInLoadingSprite(var_2_0) then
		arg_2_0:log("【load func】 " .. var_2_0 .. "  loading return false,")

		return false
	end

	NoticeModel.instance:addLoadingSprite(var_2_0)
	NoticeModel.instance:addNeedLoadImageUrl(arg_2_1)
	NoticeModel.instance:addLoadTask(arg_2_0._load, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._load, arg_2_0, 0.01)

	return false
end

function var_0_0._load(arg_3_0)
	local var_3_0 = NoticeModel.instance:popNeedLoadImageUrl()

	while var_3_0 do
		local var_3_1 = arg_3_0:getFilenameFormUrl(var_3_0)
		local var_3_2 = "notice/" .. var_3_1
		local var_3_3 = arg_3_0:getNoticeImgFilePath(var_3_2)

		if SLFramework.FileHelper.IsFileExists(var_3_3) then
			loadPersistentRes(var_3_2, SLFramework.AssetType.TEXTURE, arg_3_0._onLoadCallback, arg_3_0)
		else
			ZProj.SLPictureDownloader.Instance:Download(var_3_0, arg_3_0._downloadCallback, arg_3_0)
		end

		var_3_0 = NoticeModel.instance:popNeedLoadImageUrl()
	end

	NoticeModel.instance:removeLoadTask(arg_3_0._load, arg_3_0)
end

function var_0_0.addLoadCallback(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._callbackObj = arg_4_2
end

function var_0_0._onLoadCallback(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getFilenameFormUrl(arg_5_1.ResPath)

	NoticeModel.instance:setLoadedSprite(var_5_0)

	if arg_5_1.IsLoadSuccess then
		local var_5_1 = arg_5_0._assetItem

		arg_5_1:Retain()

		arg_5_0._assetItem = arg_5_1

		if var_5_1 then
			var_5_1:Release()
		end

		local var_5_2 = arg_5_1:GetResource()

		NoticeModel.instance:setSpriteCache(var_5_0, UnityEngine.Sprite.Create(var_5_2, UnityEngine.Rect.New(0, 0, var_5_2.width, var_5_2.height), Vector2.zero, 100, 0))
		NoticeModel.instance:setSpriteCacheDefaultSize(var_5_0, var_5_2.width, var_5_2.height)
		NoticeModel.instance:addAssetItem(arg_5_1)
		arg_5_0:_doCallback(true, var_5_0)
	else
		logError("load fail: " .. arg_5_1.ResPath)
		arg_5_0:_doCallback(false, var_5_0)
	end
end

function var_0_0._downloadCallback(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_0:getFilenameFormUrl(arg_6_4)

	NoticeModel.instance:setLoadedSprite(var_6_0)

	if arg_6_1 then
		local var_6_1 = arg_6_0:getNoticeImgFilePath("notice/" .. var_6_0)

		SLFramework.FileHelper.WriteAllBytesToPath(var_6_1, arg_6_3)
		NoticeModel.instance:setSpriteCache(var_6_0, UnityEngine.Sprite.Create(arg_6_2, UnityEngine.Rect.New(0, 0, arg_6_2.width, arg_6_2.height), Vector2.zero, 100, 0))
		NoticeModel.instance:setSpriteCacheDefaultSize(var_6_0, arg_6_2.width, arg_6_2.height)
		arg_6_0:_doCallback(true, var_6_0)
	else
		logError("download fail: " .. arg_6_4)
		arg_6_0:_doCallback(false, var_6_0)
	end
end

function var_0_0._doCallback(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		arg_7_0:log("【_doCallback func】 load success, self.filename is " .. arg_7_2)
	else
		arg_7_0:log("【_doCallback func】 load fail, self.filename is " .. arg_7_2)
	end

	NoticeModel.instance:removeLoadingSpriteCount(arg_7_2)

	if NoticeModel.instance:getLoadingSpriteCount() <= 0 then
		NoticeContentListModel.instance:onModelUpdate()
	end

	local var_7_0 = arg_7_0._callback
	local var_7_1 = arg_7_0._callbackObj

	arg_7_0._callback = nil
	arg_7_0._callbackObj = nil

	if var_7_0 then
		if var_7_1 then
			var_7_0(var_7_1, arg_7_1)
		else
			var_7_0(arg_7_1)
		end
	end
end

function var_0_0.getNoticeImgFilePath(arg_8_0, arg_8_1)
	return SLFramework.FrameworkSettings.PersistentResRootDir .. "/" .. arg_8_1
end

function var_0_0.getFilenameFormUrl(arg_9_0, arg_9_1)
	return SLFramework.FileHelper.GetFileName(string.gsub(arg_9_1, "?.*", ""), true)
end

function var_0_0.log(arg_10_0, arg_10_1)
	logWarn(string.format("【NoticeImageLog】msg : %s", arg_10_1))
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0._assetItem then
		arg_11_0._assetItem:Release()

		arg_11_0._assetItem = nil
	end
end

return var_0_0
