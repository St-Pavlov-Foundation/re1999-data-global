module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapSceneElements", DungeonMapSceneElements)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._dailyElementList = arg_1_0:getUserDataTb_()
	arg_1_0._dailyElementMats = arg_1_0:getUserDataTb_()
	arg_1_0._tweenList = {}
	arg_1_0._matKey = UnityEngine.Shader.PropertyToID("_MainCol")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.activityDungeonMo = arg_2_0.viewContainer.versionActivityDungeonBaseMo

	var_0_0.super.onOpen(arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.SelectChangeDaily, arg_2_0._onSelectChangeDaily, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.LoadSameScene, arg_2_0._onLoadSameScene, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_2_0._initElements, arg_2_0)
end

function var_0_0._onLoadSameScene(arg_3_0)
	arg_3_0:_checkTryFocusDaily()
end

function var_0_0._onSelectChangeDaily(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._tweenList) do
		if iter_4_1.tweenId then
			ZProj.TweenHelper.KillById(iter_4_1.tweenId)

			iter_4_1.tweenId = nil
		end

		if iter_4_1.to == 0 then
			iter_4_1.comp:hide()
		end
	end

	local var_4_0
	local var_4_1

	for iter_4_2, iter_4_3 in pairs(arg_4_0._dailyElementList) do
		if iter_4_3:getVisible() then
			var_4_0 = iter_4_3
		end

		iter_4_3:setWenHaoGoVisible(false)

		if iter_4_2 == arg_4_1 then
			iter_4_3:show()

			var_4_1 = iter_4_3
		else
			iter_4_3:hide()
		end
	end

	if not var_4_0 or not var_4_1 or var_4_0 == var_4_1 then
		return
	end

	arg_4_0:_tweenAlpha(var_4_0, 1, 0)
	arg_4_0:_tweenAlpha(var_4_1, 0, 1)
end

function var_0_0._tweenAlpha(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1:show()

	local var_5_0 = arg_5_0._tweenList[arg_5_1]

	if not var_5_0 then
		arg_5_0:_cloneMats(arg_5_1)

		local var_5_1 = arg_5_0._dailyElementMats[arg_5_1]

		var_5_0 = {}
		arg_5_0._tweenList[arg_5_1] = var_5_0
		var_5_0.comp = arg_5_1
		var_5_0.mats = var_5_1
		var_5_0.color = Color.white
	end

	var_5_0.from = arg_5_2
	var_5_0.to = arg_5_3
	var_5_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_5_0.color.a, arg_5_3, 0.5, arg_5_0._tweenFrame, arg_5_0._tweenFinish, arg_5_0, var_5_0, EaseType.Linear)
end

function var_0_0._tweenFrame(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.color.a = arg_6_1

	local var_6_0 = arg_6_2.mats

	if not var_6_0 then
		return
	end

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		iter_6_1:SetColor(arg_6_0._matKey, arg_6_2.color)
	end
end

function var_0_0._tweenFinish(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.comp

	arg_7_1.color.a = arg_7_1.to

	if arg_7_1.to == 0 then
		var_7_0:hide()
	end

	local var_7_1 = arg_7_1.mats

	if not var_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		iter_7_1:SetColor(arg_7_0._matKey, arg_7_1.color)
	end
end

function var_0_0._cloneMats(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getItemGo()

	if gohelper.isNil(var_8_0) then
		return
	end

	if arg_8_0._dailyElementMats[arg_8_1] then
		return
	end

	local var_8_1 = {}
	local var_8_2 = var_8_0:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for iter_8_0 = 0, var_8_2.Length - 1 do
		local var_8_3 = var_8_2[iter_8_0].material
		local var_8_4 = UnityEngine.Object.Instantiate(var_8_3)

		var_8_2[iter_8_0].material = var_8_4

		table.insert(var_8_1, var_8_4)
	end

	arg_8_0._dailyElementMats[arg_8_1] = var_8_1
end

function var_0_0._setEpisodeListVisible(arg_9_0, arg_9_1)
	var_0_0.super._setEpisodeListVisible(arg_9_0, arg_9_1)

	local var_9_0, var_9_1 = Activity126Model.instance:getRemainNum()

	for iter_9_0, iter_9_1 in pairs(arg_9_0._dailyElementList) do
		if iter_9_1:getVisible() then
			iter_9_1:setWenHaoGoVisible(var_9_0 > 0)
		end
	end
end

function var_0_0._getElements(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if arg_10_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return var_10_0
	end

	local var_10_1 = DungeonMapModel.instance:getAllElements()

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		local var_10_2 = DungeonConfig.instance:getChapterMapElement(iter_10_1)

		if arg_10_0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and var_10_2.type == DungeonEnum.ElementType.DailyEpisode and arg_10_1 >= var_10_2.mapId and arg_10_0.activityDungeonMo.episodeId ~= VersionActivity1_3DungeonEnum.ExtraEpisodeId then
			local var_10_3 = tonumber(var_10_2.param)

			if var_10_3 and lua_activity126_episode_daily.configDict[var_10_3] then
				table.insert(var_10_0, var_10_2)
			end
		elseif var_10_2.mapId == arg_10_1 then
			table.insert(var_10_0, var_10_2)
		end
	end

	return var_10_0
end

function var_0_0._showElements(arg_11_0, arg_11_1)
	if not arg_11_0._sceneGo or arg_11_0._lockShowElementAnim then
		return
	end

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		arg_11_0._skipShowElementAnim = true
	end

	local var_11_0 = arg_11_0:_getElements(arg_11_1)
	local var_11_1 = DungeonMapModel.instance:getNewElements()
	local var_11_2 = {}
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.type ~= DungeonEnum.ElementType.DailyEpisode then
			if iter_11_1.showCamera == 1 and not arg_11_0._skipShowElementAnim and (var_11_1 and tabletool.indexOf(var_11_1, iter_11_1.id) or arg_11_0._forceShowElementAnim) then
				table.insert(var_11_2, iter_11_1.id)
			else
				table.insert(var_11_3, iter_11_1)
			end
		end
	end

	arg_11_0:_showElementAnim(var_11_2, var_11_3)
	DungeonMapModel.instance:clearNewElements()
end

function var_0_0._addElement(arg_12_0, arg_12_1)
	if arg_12_0._elementList[arg_12_1.id] then
		return
	end

	local var_12_0 = UnityEngine.GameObject.New(tostring(arg_12_1.id))

	gohelper.addChild(arg_12_0._elementRoot, var_12_0)

	local var_12_1 = MonoHelper.addLuaComOnceToGo(var_12_0, DungeonMapElement, {
		arg_12_1,
		arg_12_0._mapScene,
		arg_12_0
	})

	arg_12_0._elementList[arg_12_1.id] = var_12_1

	if arg_12_1.type == DungeonEnum.ElementType.DailyEpisode then
		arg_12_0._dailyElementList[tonumber(arg_12_1.param)] = var_12_1

		var_12_1:hide()
	end

	if var_12_1:showArrow() then
		local var_12_2 = arg_12_0.viewContainer:getSetting().otherRes[5]
		local var_12_3 = arg_12_0:getResInst(var_12_2, arg_12_0._goarrow)
		local var_12_4 = gohelper.findChild(var_12_3, "mesh")
		local var_12_5, var_12_6, var_12_7 = transformhelper.getLocalRotation(var_12_4.transform)
		local var_12_8 = gohelper.getClick(gohelper.findChild(var_12_3, "click"))

		var_12_8:AddClickListener(arg_12_0._arrowClick, arg_12_0, arg_12_1.id)

		arg_12_0._arrowList[arg_12_1.id] = {
			go = var_12_3,
			rotationTrans = var_12_4.transform,
			initRotation = {
				var_12_5,
				var_12_6,
				var_12_7
			},
			arrowClick = var_12_8
		}

		arg_12_0:_updateArrow(var_12_1)
	end
end

function var_0_0._onAddAnimElementDone(arg_13_0)
	local var_13_0 = Activity126Model.instance:getShowDailyId()
	local var_13_1 = arg_13_0._dailyElementList[var_13_0]

	if var_13_1 then
		var_13_1:show()

		local var_13_2, var_13_3 = Activity126Model.instance:getRemainNum()

		var_13_1:setWenHaoGoVisible(var_13_2 > 0)
	end

	if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonChangeView) then
		arg_13_0:_checkTryFocusDaily()
	end
end

function var_0_0._checkTryFocusDaily(arg_14_0)
	if arg_14_0._tryFocusDaily then
		arg_14_0:focusDaily()

		arg_14_0._tryFocusDaily = nil
	end
end

function var_0_0.focusDaily(arg_15_0)
	arg_15_0._tryFocusDaily = true

	if arg_15_0.viewContainer.viewParam and arg_15_0.viewContainer.viewParam.showDaily then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0._dailyElementList) do
		if iter_15_1:getVisible() then
			arg_15_0._tryFocusDaily = nil

			arg_15_0:clickElement(iter_15_1:getElementId())

			return
		end
	end
end

function var_0_0._onCloseViewFinish(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.VersionActivity1_3DungeonChangeView then
		arg_16_0:_checkTryFocusDaily()
	end
end

function var_0_0.onClose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._tweenList) do
		if iter_17_1.tweenId then
			ZProj.TweenHelper.KillById(iter_17_1.tweenId)

			iter_17_1.tweenId = nil
		end
	end
end

return var_0_0
