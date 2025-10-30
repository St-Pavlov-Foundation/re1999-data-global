module("modules.logic.fight.view.FightLoadingView", package.seeall)

local var_0_0 = class("FightLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocanvasgroup = gohelper.findChild(arg_1_0.viewGO, "#go_canvasgroup")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_canvasgroup/center/name/#txt_namecn")
	arg_1_0._gonameen = gohelper.findChild(arg_1_0.viewGO, "#go_canvasgroup/center/name/#txt_namecn/eye/#go_nameEn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_canvasgroup/center/name/#txt_namecn/eye/#go_nameEn/#txt_nameen")
	arg_1_0._txtContent = gohelper.findChildText(arg_1_0.viewGO, "#go_canvasgroup/center/tips/#txt_describe")
	arg_1_0._simagenamebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_canvasgroup/center/#simage_namebg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagenamebg:LoadImage(ResUrl.getFightLoadingIcon("bg_biaotiheiying"))

	arg_4_0._canvasGroup = arg_4_0._gocanvasgroup:GetComponent(typeof(UnityEngine.CanvasGroup))

	PostProcessingMgr.instance:setBlurWeight(1)

	arg_4_0._scene = GameSceneMgr.instance:getCurScene()

	arg_4_0._scene.director:registerCallback(FightSceneEvent.OnPrepareFinish, arg_4_0._delayClose, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._sceneId = arg_5_0.viewParam
	arg_5_0._sceneConfig = arg_5_0._sceneId and lua_scene.configDict[arg_5_0._sceneId]

	arg_5_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Mapopen)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0:_setRandomText()

	local var_6_0 = FightModel.instance:getFightParam()
	local var_6_1 = var_6_0 and var_6_0.episodeId
	local var_6_2 = var_6_1 and DungeonConfig.instance:getEpisodeCO(var_6_1)

	if var_6_2 and var_6_2.type == DungeonEnum.EpisodeType.WeekWalk then
		local var_6_3 = WeekWalkModel.instance:getCurMapId()

		if not WeekWalkModel.isShallowMap(var_6_3) then
			local var_6_4 = WeekWalkModel.instance:getCurMapInfo()
			local var_6_5 = lua_weekwalk_scene.configDict[var_6_4.sceneId]

			arg_6_0:_setName(var_6_5.typeName, "LIMBO")

			return
		end
	end

	if arg_6_0._sceneConfig then
		arg_6_0:_setName(arg_6_0._sceneConfig.name, arg_6_0._sceneConfig.nameen)
	end
end

function var_0_0._setName(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = GameUtil.getTextWidthByLine(arg_7_0._txtnamecn, arg_7_1, 120) / 2 + 100

	recthelper.setWidth(arg_7_0._gonameen.transform, var_7_0)

	arg_7_0._txtnamecn.text = arg_7_1
	arg_7_0._txtnameen.text = arg_7_2
end

function var_0_0._delayClose(arg_8_0)
	arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, arg_8_0._onFrame, arg_8_0._onFinish, arg_8_0, nil, EaseType.Linear)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0._onFrame(arg_10_0, arg_10_1)
	arg_10_0._canvasGroup.alpha = arg_10_1
end

function var_0_0._onFinish(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._scene.director:unregisterCallback(FightSceneEvent.OnPrepareFinish, arg_12_0._delayClose, arg_12_0)

	if arg_12_0._tweenId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenId)
	end

	PostProcessingMgr.instance:setBlurWeight(1)
	arg_12_0._simagenamebg:UnLoadImage()
end

function var_0_0._setRandomText(arg_13_0)
	local var_13_0 = arg_13_0:_getFitTips()
	local var_13_1 = arg_13_0:_getRandomCO(var_13_0)

	if var_13_1 then
		arg_13_0._txtContent.text = var_13_1.content
	end
end

function var_0_0._getFitTips(arg_14_0)
	local var_14_0 = LoadingView.getLoadingSceneType(SceneType.Fight)
	local var_14_1 = PlayerModel.instance:getPlayerLevel()
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in pairs(SceneConfig.instance:getLoadingTexts()) do
		local var_14_3 = FightStrUtil.instance:getSplitToNumberCache(iter_14_1.scenes, "#")

		for iter_14_2, iter_14_3 in pairs(var_14_3) do
			if iter_14_3 == var_14_0 then
				if var_14_1 == 0 then
					table.insert(var_14_2, iter_14_1)
				elseif var_14_1 >= iter_14_1.unlocklevel then
					table.insert(var_14_2, iter_14_1)
				end
			end
		end
	end

	return var_14_2
end

function var_0_0._getRandomCO(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		var_15_0 = var_15_0 + iter_15_1.weight
	end

	local var_15_1 = math.floor(math.random() * var_15_0)

	for iter_15_2, iter_15_3 in ipairs(arg_15_1) do
		if var_15_1 < iter_15_3.weight then
			return iter_15_3
		else
			var_15_1 = var_15_1 - iter_15_3.weight
		end
	end

	local var_15_2 = #arg_15_1

	if var_15_2 > 1 then
		return arg_15_1[math.random(1, var_15_2)]
	elseif var_15_2 == 1 then
		return arg_15_1[1]
	end
end

return var_0_0
