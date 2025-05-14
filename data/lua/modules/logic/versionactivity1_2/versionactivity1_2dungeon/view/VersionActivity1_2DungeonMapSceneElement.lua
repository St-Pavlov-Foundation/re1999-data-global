module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapSceneElement", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapSceneElement", DungeonMapSceneElements)
local var_0_1 = {
	12101,
	12102,
	12104,
	12105
}
local var_0_2 = {
	12101011
}

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	arg_1_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveAct116InfoUpdatePush, arg_1_0._onReceiveAct116InfoUpdatePush, arg_1_0)
end

function var_0_0._OnRemoveElement(arg_2_0, arg_2_1)
	if not arg_2_0._elementList then
		return
	end

	if not arg_2_0._elementList[arg_2_1] then
		return
	end

	var_0_0.super._OnRemoveElement(arg_2_0, arg_2_1)
end

function var_0_0._addElement(arg_3_0, arg_3_1)
	if arg_3_1.id == 12101091 then
		return
	end

	if arg_3_0._elementList[arg_3_1.id] then
		return
	end

	local var_3_0 = UnityEngine.GameObject.New(tostring(arg_3_1.id))

	gohelper.setActive(var_3_0, arg_3_0:_checkShowDailyElement(arg_3_1.id))
	gohelper.addChild(arg_3_0._elementRoot, var_3_0)

	local var_3_1 = MonoHelper.addLuaComOnceToGo(var_3_0, VersionActivity1_2DungeonMapElement, {
		arg_3_1,
		arg_3_0._mapScene,
		arg_3_0
	})

	arg_3_0._elementList[arg_3_1.id] = var_3_1

	if var_3_1:showArrow() then
		local var_3_2 = arg_3_0.viewContainer:getSetting().otherRes[5]
		local var_3_3 = arg_3_0:getResInst(var_3_2, arg_3_0._goarrow)
		local var_3_4 = gohelper.findChild(var_3_3, "mesh")
		local var_3_5, var_3_6, var_3_7 = transformhelper.getLocalRotation(var_3_4.transform)
		local var_3_8 = gohelper.getClick(gohelper.findChild(var_3_3, "click"))

		var_3_8:AddClickListener(arg_3_0._arrowClick, arg_3_0, arg_3_1.id)

		arg_3_0._arrowList[arg_3_1.id] = {
			go = var_3_3,
			rotationTrans = var_3_4.transform,
			initRotation = {
				var_3_5,
				var_3_6,
				var_3_7
			},
			arrowClick = var_3_8
		}

		arg_3_0:_updateArrow(var_3_1)
	end
end

function var_0_0._onReceiveAct116InfoUpdatePush(arg_4_0)
	if arg_4_0._elementList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._elementList) do
			gohelper.setActive(iter_4_1._go, arg_4_0:_checkShowDailyElement(iter_4_1._config.id))
		end
	end

	arg_4_0.viewContainer.mapScene:_showDailyBtn()
end

function var_0_0._showElements(arg_5_0, arg_5_1)
	if not arg_5_0._sceneGo or arg_5_0._lockShowElementAnim then
		return
	end

	local var_5_0 = DungeonMapModel.instance:getElements(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade and not VersionActivity1_2DungeonModel.instance:getElementData(iter_5_1.id) then
			Activity116Rpc.instance:sendGet116InfosRequest()

			break
		end
	end

	local var_5_1 = DungeonMapModel.instance:getNewElements()
	local var_5_2 = {}
	local var_5_3 = {}

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		if iter_5_3.showCamera == 1 and not arg_5_0._skipShowElementAnim and (var_5_1 and tabletool.indexOf(var_5_1, iter_5_3.id) or arg_5_0._forceShowElementAnim) then
			table.insert(var_5_2, iter_5_3.id)
		else
			table.insert(var_5_3, iter_5_3)
		end
	end

	arg_5_0:_showElementAnim(var_5_2, var_5_3)
	DungeonMapModel.instance:clearNewElements()
end

function var_0_0._checkShowDailyElement(arg_6_0, arg_6_1)
	if lua_chapter_map_element.configDict[arg_6_1].type == DungeonEnum.ElementType.DailyEpisode then
		return VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(arg_6_1)
	end

	return true
end

function var_0_0.setElementDown(arg_7_0, arg_7_1)
	if not gohelper.isNil(arg_7_0._mapScene._uiGo) then
		return
	end

	arg_7_0.curSelectId = arg_7_1._config.id
	arg_7_0._elementMouseDown = arg_7_1
end

function var_0_0._onFinishGuide(arg_8_0, arg_8_1)
	if (arg_8_0._lockShowElementAnim or arg_8_0._forceShowElementId ~= nil and tabletool.indexOf(var_0_2, arg_8_0._forceShowElementId)) and tabletool.indexOf(var_0_1, arg_8_1) then
		arg_8_0._lockShowElementAnim = nil
		arg_8_0._forceShowElementId = nil

		GuideModel.instance:clearFlagByGuideId(arg_8_1)
		arg_8_0:_initElements()
	end
end

return var_0_0
