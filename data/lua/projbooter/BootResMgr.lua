module("projbooter.BootResMgr", package.seeall)

local var_0_0 = class("BootResMgr")

var_0_0.OriginBgPath = "bootres/prefabs/originbg.prefab"
var_0_0.LoadingViewPath = "bootres/prefabs/loadingview.prefab"
var_0_0.MsgBoxViewPath = "bootres/prefabs/msgboxview.prefab"
var_0_0.NoticeViewPath = "bootres/prefabs/noticeview.prefab"
var_0_0.VoiceViewPath = "bootres/prefabs/voicedownloadview.prefab"
var_0_0.VersionViewPath = "bootres/prefabs/versionview.prefab"
var_0_0.AdaptionBgViewPath = "bootres/prefabs/adaptionbg.prefab"
var_0_0.FontPath = "Font"

function var_0_0.ctor(arg_1_0)
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	arg_1_0._loadedCount = 0
	arg_1_0._orginBgRoot = UnityEngine.GameObject.Find("UIRoot/OriginBg")
	arg_1_0._popupTopRoot = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")
	arg_1_0._topRoot = UnityEngine.GameObject.Find("UIRoot/TOP")
	arg_1_0._msgRoot = UnityEngine.GameObject.Find("UIRoot/MESSAGE")
	arg_1_0._allRes = {}
	arg_1_0._allRes.imgs = {}
	arg_1_0._hasShowIndexs = {}

	local var_1_0 = arg_1_0:_getRandomCO()
	local var_1_1 = string.format("bootres/textures/%s.png", var_1_0.bg)

	arg_1_0._allRes.imgs[var_1_1] = {
		path = var_1_1,
		config = var_1_0
	}
	arg_1_0._allRes.prefabs = {
		[var_0_0.OriginBgPath] = {
			path = var_0_0.OriginBgPath,
			layer = arg_1_0._orginBgRoot
		},
		[var_0_0.LoadingViewPath] = {
			path = var_0_0.LoadingViewPath,
			layer = arg_1_0._topRoot
		},
		[var_0_0.MsgBoxViewPath] = {
			path = var_0_0.MsgBoxViewPath,
			layer = arg_1_0._msgRoot
		},
		[var_0_0.NoticeViewPath] = {
			path = var_0_0.NoticeViewPath,
			layer = arg_1_0._topRoot
		},
		[var_0_0.VoiceViewPath] = {
			path = var_0_0.VoiceViewPath,
			layer = arg_1_0._popupTopRoot
		},
		[var_0_0.VersionViewPath] = {
			path = var_0_0.VersionViewPath,
			layer = arg_1_0._popupTopRoot
		},
		[var_0_0.AdaptionBgViewPath] = {
			path = var_0_0.AdaptionBgViewPath,
			layer = arg_1_0._topRoot
		}
	}
end

function var_0_0.getAutoMaskGo(arg_2_0)
	return arg_2_0._allRes.prefabs[var_0_0.AutoMaskPath].go
end

function var_0_0.getLoadingViewGo(arg_3_0)
	return arg_3_0._allRes.prefabs[var_0_0.LoadingViewPath].go
end

function var_0_0.getMsgBoxGo(arg_4_0)
	return arg_4_0._allRes.prefabs[var_0_0.MsgBoxViewPath].go
end

function var_0_0.getNoticeViewGo(arg_5_0)
	return arg_5_0._allRes.prefabs[var_0_0.NoticeViewPath].go
end

function var_0_0.getVoiceViewGo(arg_6_0)
	return arg_6_0._allRes.prefabs[var_0_0.VoiceViewPath].go
end

function var_0_0.getVersionViewGo(arg_7_0)
	return arg_7_0._allRes.prefabs[var_0_0.VersionViewPath].go
end

function var_0_0.getAdaptionViewGo(arg_8_0)
	return arg_8_0._allRes.prefabs[var_0_0.AdaptionBgViewPath].go
end

function var_0_0.getOriginBgGo(arg_9_0)
	return arg_9_0._allRes.prefabs[var_0_0.OriginBgPath].go
end

function var_0_0.getLoadingBg(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == 1 then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._allRes.imgs) do
			if arg_10_2 then
				arg_10_2(arg_10_3, iter_10_1.texture, iter_10_1.config)
			end

			return
		end
	else
		local var_10_0 = arg_10_0:_getRandomCO()
		local var_10_1 = string.format("bootres/textures/%s.png", var_10_0.bg)

		if not arg_10_0._allRes.imgs[var_10_1] then
			arg_10_0._allRes.imgs[var_10_1] = {}
		end

		arg_10_0._allRes.imgs[var_10_1].path = var_10_1
		arg_10_0._allRes.imgs[var_10_1].config = var_10_0

		if not arg_10_0._allRes.imgs[var_10_1].texture then
			loadAbAsset(arg_10_0._allRes.imgs[var_10_1].path, false, function(arg_11_0)
				if not arg_10_0._allRes then
					return
				end

				arg_10_0._allRes.imgs[var_10_1].texture = arg_11_0:GetResource()

				if arg_10_2 then
					arg_10_2(arg_10_3, arg_10_0._allRes.imgs[var_10_1].texture, arg_10_0._allRes.imgs[var_10_1].config)
				end
			end)
		elseif arg_10_2 then
			arg_10_2(arg_10_3, arg_10_0._allRes.imgs[var_10_1].texture, arg_10_0._allRes.imgs[var_10_1].config)
		end
	end
end

function var_0_0._getRandomCO(arg_12_0)
	local var_12_0 = booterLoadingConfig()
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not arg_12_0._hasShowIndexs[iter_12_0] then
			var_12_1 = var_12_1 + iter_12_1.weight
		end
	end

	local var_12_2 = math.floor(math.random() * var_12_1)

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		if not arg_12_0._hasShowIndexs[iter_12_2] then
			if var_12_2 < iter_12_3.weight then
				arg_12_0._hasShowIndexs[iter_12_2] = true

				return iter_12_3
			else
				var_12_2 = var_12_2 - iter_12_3.weight
			end
		end
	end

	arg_12_0._hasShowIndexs = {}

	local var_12_3 = math.random(1, #var_12_0)

	arg_12_0._hasShowIndexs[var_12_3] = true

	return var_12_0[var_12_3]
end

function var_0_0.startLoading(arg_13_0, arg_13_1, arg_13_2)
	logNormal("BootResMgr.startLoading loadedCb = " .. tostring(arg_13_1) .. " cbObj = " .. tostring(arg_13_2))

	arg_13_0._loadedCb = arg_13_1
	arg_13_0._cbObj = arg_13_2

	local var_13_0 = GameConfig:GetCurLangType()
	local var_13_1 = BootLangEnum.LangFont[var_13_0] or BootLangEnum.Font.b_hwzs

	loadAbAsset(var_13_1, false, arg_13_0._onloadedFont, arg_13_0)
end

function var_0_0._onloadedFont(arg_14_0, arg_14_1)
	if arg_14_1.IsLoadSuccess then
		local var_14_0 = arg_14_1:GetResource()

		BootLangFontMgr.instance:init(var_14_0)
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0._allRes.prefabs) do
		arg_14_0._loadedCount = arg_14_0._loadedCount + 1

		loadAbAsset(iter_14_0, false, arg_14_0._onPrefabLoaded, arg_14_0)
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._allRes.imgs) do
		arg_14_0._loadedCount = arg_14_0._loadedCount + 1

		loadAbAsset(iter_14_3.path, false, arg_14_0._onImgLoaded, arg_14_0)
	end
end

function var_0_0._onImgLoaded(arg_15_0, arg_15_1)
	if arg_15_1.IsLoadSuccess then
		arg_15_0._loadedCount = arg_15_0._loadedCount - 1

		local var_15_0 = arg_15_1:GetResource()

		arg_15_0._allRes.imgs[arg_15_1.ResPath].texture = var_15_0

		arg_15_0:_checkResLoadFinished()
	end
end

function var_0_0._onPrefabLoaded(arg_16_0, arg_16_1)
	if arg_16_1.IsLoadSuccess then
		if var_0_0.AdaptionBgViewPath == arg_16_1.ResPath then
			GameAdaptionBgMgr.instance:onAssetResLoaded(arg_16_1)
		end

		arg_16_0._loadedCount = arg_16_0._loadedCount - 1

		local var_16_0 = arg_16_1:GetResource()
		local var_16_1 = UnityEngine.GameObject.Instantiate(var_16_0)

		var_16_1:SetActive(false)

		local var_16_2 = arg_16_0._allRes.prefabs[arg_16_1.ResPath].layer or arg_16_0._topRoot

		var_16_1.transform:SetParent(var_16_2.transform, false)

		arg_16_0._allRes.prefabs[arg_16_1.ResPath].go = var_16_1

		arg_16_0:_checkResLoadFinished()
	end
end

function var_0_0._checkResLoadFinished(arg_17_0)
	if arg_17_0._loadedCount == 0 then
		logNormal("BootResMgr onloaded, 所有的启动UI资源都加载完成了！")

		if arg_17_0._loadedCb then
			arg_17_0._loadedCb(arg_17_0._cbObj)
		end
	end
end

function var_0_0.dispose(arg_18_0)
	if arg_18_0._disposed then
		return
	end

	BootLangFontMgr.instance:dispose()
	BootLoadingView.instance:dispose()
	BootMsgBox.instance:dispose()
	BootNoticeView.instance:dispose()
	BootVoiceView.instance:dispose()
	BootVersionView.instance:dispose()

	if arg_18_0._allRes then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._allRes.prefabs) do
			UnityEngine.GameObject.Destroy(iter_18_1.go)
		end

		arg_18_0._allRes = nil
	end

	arg_18_0._disposed = true
end

var_0_0.instance = var_0_0.New()

return var_0_0
