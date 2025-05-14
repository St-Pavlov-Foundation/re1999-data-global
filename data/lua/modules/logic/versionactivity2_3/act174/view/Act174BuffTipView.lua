module("modules.logic.versionactivity2_3.act174.view.Act174BuffTipView", package.seeall)

local var_0_0 = class("Act174BuffTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closetip")
	arg_1_0._goscrolltips = gohelper.findChild(arg_1_0.viewGO, "#go_scrolltips")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_scrolltips/viewport/content/go_title/#txt_title")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_scrolltips/viewport/content/go_title/#image_icon")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_scrolltips/viewport/content/#go_skillitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosetip:RemoveClickListener()
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goContent = gohelper.findChild(arg_5_0.viewGO, "#go_scrolltips/viewport/content")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	if not arg_7_0.viewParam then
		logError("please open with param")

		return
	end

	local var_7_0 = Activity174Model.instance:getActInfo():getGameInfo()

	if arg_7_0.viewParam.isEnemy then
		local var_7_1 = var_7_0:getFightInfo().matchInfo

		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageicon, "act174_ready_icon_enemy")

		arg_7_0._txttitle.text = luaLang("act174_enhance_enemy")

		if var_7_0:getFightInfo() then
			arg_7_0.enhanceList = var_7_1.enhanceId
			arg_7_0.endEnhanceList = var_7_1.endEnhanceId
		else
			logError("dont exist fightInfo")

			return
		end
	else
		local var_7_2 = var_7_0:getWarehouseInfo()

		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageicon, "act174_ready_icon_player")

		arg_7_0._txttitle.text = luaLang("act174_enhance_player")
		arg_7_0.enhanceList = var_7_2.enhanceId
		arg_7_0.endEnhanceList = var_7_2.endEnhanceId
	end

	arg_7_0.buffIconList = arg_7_0:getUserDataTb_()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.enhanceList) do
		local var_7_3 = gohelper.cloneInPlace(arg_7_0._goskillitem)
		local var_7_4 = lua_activity174_enhance.configDict[iter_7_1]
		local var_7_5 = gohelper.findChildText(var_7_3, "txt_skill")
		local var_7_6 = gohelper.findChildSingleImage(var_7_3, "skillicon")
		local var_7_7 = gohelper.findChildText(var_7_3, "layout/txt_dec")

		var_7_5.text = var_7_4.title

		local var_7_8 = var_7_4.desc

		if arg_7_0.endEnhanceList and tabletool.indexOf(arg_7_0.endEnhanceList, iter_7_1) then
			var_7_8 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_enhance_overduea"), var_7_8)
		end

		var_7_7.text = var_7_8

		var_7_6:LoadImage(ResUrl.getAct174BuffIcon(var_7_4.icon))

		arg_7_0.buffIconList[#arg_7_0.buffIconList + 1] = var_7_6
	end

	gohelper.setActive(arg_7_0._goskillitem, false)
	TaskDispatcher.runDelay(arg_7_0.refreshAnchor, arg_7_0, 0.01)
end

function var_0_0.refreshAnchor(arg_8_0)
	local var_8_0 = arg_8_0._goscrolltips.transform
	local var_8_1 = recthelper.getHeight(var_8_0)
	local var_8_2 = recthelper.getHeight(arg_8_0._goContent.transform)
	local var_8_3 = var_8_1 < var_8_2 and var_8_1 or var_8_2
	local var_8_4 = arg_8_0.viewParam.pos

	if arg_8_0.viewParam.isDown then
		recthelper.setAnchor(var_8_0, var_8_4.x, var_8_4.y + var_8_3)
	else
		recthelper.setAnchor(var_8_0, var_8_4.x, var_8_4.y)
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.buffIconList) do
		iter_10_1:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_10_0.refreshAnchor, arg_10_0)
end

return var_0_0
