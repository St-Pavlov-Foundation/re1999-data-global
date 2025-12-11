module("modules.logic.survival.view.shelter.SurvivalMonsterEventSelectBuffItem", package.seeall)

local var_0_0 = class("SurvivalMonsterEventSelectBuffItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")
	arg_1_0._scrolltag = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tag")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tag/viewport/content/#go_tagitem")
	arg_1_0._imageType = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_tag/viewport/content/#go_tagitem/#image_Type")
	arg_1_0._txtType = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tag/viewport/content/#go_tagitem/#txt_Type")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_tag/viewport/content/#go_tagitem/#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gotagitem, false)

	arg_5_0._gounfinish = gohelper.findChild(arg_5_0.viewGO, "go_unfinish")
	arg_5_0._gofinished = gohelper.findChild(arg_5_0.viewGO, "go_finished")
	arg_5_0._ani = arg_5_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.initItem(arg_8_0, arg_8_1)
	arg_8_0._co = SurvivalConfig.instance:getShelterIntrudeSchemeConfig(arg_8_1)

	if arg_8_0._co == nil then
		logError("SurvivalMonsterEventBuffItem:initItem id is nil" .. arg_8_1)
	end

	arg_8_0._txtdec.text = arg_8_0._co and arg_8_0._co.desc or ""

	arg_8_0:_initTagItem()
end

function var_0_0.updateItem(arg_9_0)
	local var_9_0 = SurvivalShelterMonsterModel.instance:calBuffIsRepress(arg_9_0._co and arg_9_0._co.id or nil)

	gohelper.setActive(arg_9_0._gofinished, var_9_0)

	if arg_9_0._lastState == nil or arg_9_0._lastState ~= var_9_0 then
		arg_9_0:playAni(var_9_0 and "finished" or "open")
	end

	arg_9_0._lastState = var_9_0
end

function var_0_0._initTagItem(arg_10_0)
	if arg_10_0._tagItems == nil then
		arg_10_0._tagItems = arg_10_0:getUserDataTb_()
	end

	local var_10_0 = SurvivalConfig.instance:getMonsterBuffConfigTag(arg_10_0._co and arg_10_0._co.id or nil)

	for iter_10_0 = 1, #var_10_0 do
		local var_10_1 = var_10_0[iter_10_0]

		if var_10_1 then
			local var_10_2 = lua_survival_tag.configDict[var_10_1]
			local var_10_3 = gohelper.cloneInPlace(arg_10_0._gotagitem, var_10_1)

			if var_10_2 then
				local var_10_4 = gohelper.findChildImage(var_10_3, "#image_Type")
				local var_10_5 = SurvivalConst.ShelterTagColor[var_10_2.tagType]

				if var_10_5 then
					var_10_4.color = GameUtil.parseColor(var_10_5)
				end

				local var_10_6 = gohelper.findChildText(var_10_3, "#txt_Type")
				local var_10_7 = gohelper.findButtonWithAudio(var_10_3, "#btn_click")

				var_10_6.text = var_10_2.name
			end

			gohelper.setActive(var_10_3, true)
			table.insert(arg_10_0._tagItems, var_10_3)
		end
	end
end

function var_0_0.playAni(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0._ani:Play(arg_11_1, 0, 0)
	end
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
