module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipSpineView", package.seeall)

local var_0_0 = class("Season123_2_3EquipSpineView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "left/hero/#go_herocontainer/dynamiccontainer/#go_spine")

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
	arg_4_0._uiSpine = GuiModelAgent.Create(arg_4_0._gospine, true)

	arg_4_0:createSpine()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._uiSpine then
		arg_5_0._uiSpine:onDestroy()

		arg_5_0._uiSpine = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshHeroSkin()
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0._uiSpine then
		arg_7_0._uiSpine:setModelVisible(false)
	end
end

function var_0_0.createSpine(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0._uiSpine:useRT()

		local var_8_0 = ViewMgr.instance:getUIRoot()

		arg_8_0._uiSpine:setImgSize(var_8_0.transform.sizeDelta.x * 1.25, var_8_0.transform.sizeDelta.y * 1.25)
		arg_8_0._uiSpine:setResPath(arg_8_1, arg_8_0.onSpineLoaded, arg_8_0)

		local var_8_1, var_8_2 = SkinConfig.instance:getSkinOffset(arg_8_1.characterGetViewOffset)

		if var_8_2 then
			var_8_1, _ = SkinConfig.instance:getSkinOffset(arg_8_1.characterViewOffset)
			var_8_1 = SkinConfig.instance:getAfterRelativeOffset(505, var_8_1)
		end

		logNormal(string.format("offset = %s, %s, scale = %s", tonumber(var_8_1[1]), tonumber(var_8_1[2]), tonumber(var_8_1[3])))
		recthelper.setAnchor(arg_8_0._gospine.transform, tonumber(var_8_1[1]), tonumber(var_8_1[2]))
		transformhelper.setLocalScale(arg_8_0._gospine.transform, tonumber(var_8_1[3]), tonumber(var_8_1[3]), tonumber(var_8_1[3]))
	end
end

function var_0_0.refreshHeroSkin(arg_9_0)
	local var_9_0 = Season123EquipItemListModel.instance.curPos
	local var_9_1 = Season123EquipItemListModel.instance:getPosHeroUid(var_9_0)

	if not var_9_1 or var_9_1 == Season123EquipItemListModel.EmptyUid then
		gohelper.setActive(arg_9_0._gospine, false)

		return nil
	end

	local var_9_2 = HeroModel.instance:getById(tostring(var_9_1)) or HeroGroupTrialModel.instance:getById(var_9_1)

	if Season123EquipItemListModel.instance.stage ~= nil then
		var_9_2 = Season123HeroUtils.getHeroMO(Season123EquipItemListModel.instance.activityId, var_9_1, Season123EquipItemListModel.instance.stage)
	end

	if not var_9_2 then
		logError(string.format("pos heroId [%s] can't find MO", tostring(var_9_1)))
		gohelper.setActive(arg_9_0._gospine, false)

		return nil
	end

	local var_9_3 = false
	local var_9_4 = var_9_2.skin
	local var_9_5 = SkinConfig.instance:getSkinCo(var_9_4)

	if var_9_5 then
		gohelper.setActive(arg_9_0._gospine, true)
		arg_9_0:createSpine(var_9_5)
	else
		logError("skin config nil ! skin Id = " .. tostring(var_9_4))
	end
end

function var_0_0.onSpineLoaded(arg_10_0)
	arg_10_0._spineLoaded = true

	arg_10_0._uiSpine:setUIMask(true)
end

return var_0_0
