module("modules.logic.seasonver.act123.view1_9.Season123_1_9HeroGroupReplaySelectView", package.seeall)

local var_0_0 = class("Season123_1_9HeroGroupReplaySelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnmultispeed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed")
	arg_1_0._txtmultispeed = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/Label")
	arg_1_0._btnclosemult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closemult")
	arg_1_0._gomultPos = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/#go_multpos")
	arg_1_0._gomultispeed = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed")
	arg_1_0._gomultContent = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed/Viewport/Content")
	arg_1_0._gomultitem = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed/Viewport/Content/#go_multitem")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay/#go_cost/#image_icon")
	arg_1_0._txtcostNum = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay/#go_cost/#txt_num")
	arg_1_0._godropbg = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed/Viewport/bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmultispeed:AddClickListener(arg_2_0._btnmultispeedOnClick, arg_2_0)
	arg_2_0._btnclosemult:AddClickListener(arg_2_0._btnclosemultOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmultispeed:RemoveClickListener()
	arg_3_0._btnclosemult:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._isMultiOpen = false
	arg_4_0.rectdropbg = arg_4_0._godropbg.transform

	arg_4_0:refreshMulti()
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:initCostIcon()
	arg_6_0:initMultiGroup()
	arg_6_0:refreshSelection()
end

function var_0_0.onClose(arg_7_0)
	return
end

var_0_0.ItemHeight = 92

function var_0_0.initMultiGroup(arg_8_0)
	arg_8_0._multSpeedItems = {}
	arg_8_0.maxMultiplicationTimes = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication)

	local var_8_0 = arg_8_0._gomultContent.transform
	local var_8_1

	if Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		local var_8_2 = Season123HeroGroupModel.instance:getMultiplicationTicket()

		var_8_1 = math.min(arg_8_0.maxMultiplicationTimes, var_8_2)
	else
		var_8_1 = 1
	end

	for iter_8_0 = 1, arg_8_0.maxMultiplicationTimes do
		local var_8_3 = var_8_0:GetChild(iter_8_0 - 1)
		local var_8_4 = arg_8_0.maxMultiplicationTimes - iter_8_0 + 1

		if var_8_1 < var_8_4 then
			gohelper.setActive(var_8_3, false)
		else
			gohelper.setActive(var_8_3, true)
			arg_8_0:initMultSpeedItem(var_8_3.gameObject, var_8_4, var_8_1)
		end
	end

	recthelper.setHeight(arg_8_0.rectdropbg, var_0_0.ItemHeight * var_8_1)
end

function var_0_0.initMultSpeedItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._multSpeedItems[arg_9_2] then
		local var_9_0 = gohelper.findChild(arg_9_1, "line")
		local var_9_1 = gohelper.findChildTextMesh(arg_9_1, "num")
		local var_9_2 = gohelper.findChild(arg_9_1, "selecticon")

		arg_9_0:addClickCb(gohelper.getClick(arg_9_1), arg_9_0.onClickSetSpeed, arg_9_0, arg_9_2)

		var_9_1.text = luaLang("multiple") .. arg_9_2

		gohelper.setActive(var_9_0, arg_9_2 ~= arg_9_3)

		arg_9_0._multSpeedItems[arg_9_2] = arg_9_0:getUserDataTb_()
		arg_9_0._multSpeedItems[arg_9_2].txtnum = var_9_1
		arg_9_0._multSpeedItems[arg_9_2].goselecticon = var_9_2
	end
end

function var_0_0.initCostIcon(arg_10_0)
	local var_10_0 = Season123HeroGroupModel.instance.activityId
	local var_10_1 = Season123Config.instance:getEquipItemCoin(var_10_0, Activity123Enum.Const.UttuTicketsCoin)

	if var_10_1 then
		local var_10_2 = CurrencyConfig.instance:getCurrencyCo(var_10_1)

		if not var_10_2 then
			return
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_10_0._imageicon, tostring(var_10_2.icon) .. "_1")
	else
		logNormal("Season123 ticketId is nil : " .. tostring(var_10_0))
	end
end

function var_0_0.refreshMulti(arg_11_0)
	gohelper.setActive(arg_11_0._gomultispeed, arg_11_0._isMultiOpen)
	gohelper.setActive(arg_11_0._btnclosemult, arg_11_0._isMultiOpen)

	arg_11_0._gomultispeed.transform.position = arg_11_0._gomultPos.transform.position
end

function var_0_0.onClickSetSpeed(arg_12_0, arg_12_1)
	arg_12_0:setMultSpeed(arg_12_1)
end

local var_0_1 = GameUtil.parseColor("#efb785")
local var_0_2 = GameUtil.parseColor("#C3BEB6")

function var_0_0.setMultSpeed(arg_13_0, arg_13_1)
	Season123HeroGroupController.instance:setMultiplication(arg_13_1)

	local var_13_0 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(Season123HeroGroupModel.instance.multiplication))

	arg_13_0._isMultiOpen = false

	arg_13_0:refreshMulti()
	arg_13_0:refreshSelection()
end

function var_0_0.refreshSelection(arg_14_0)
	local var_14_0 = Season123HeroGroupModel.instance.multiplication

	arg_14_0._txtmultispeed.text = luaLang("multiple") .. var_14_0
	arg_14_0._txtcostNum.text = "-" .. tostring(var_14_0)

	for iter_14_0 = 1, arg_14_0.maxMultiplicationTimes do
		local var_14_1 = arg_14_0._multSpeedItems[iter_14_0]

		if var_14_1 then
			var_14_1.txtnum.color = var_14_0 == iter_14_0 and var_0_1 or var_0_2

			gohelper.setActive(var_14_1.goselecticon, var_14_0 == iter_14_0)
		end
	end
end

function var_0_0._btnmultispeedOnClick(arg_15_0)
	arg_15_0._isMultiOpen = not arg_15_0._isMultiOpen

	arg_15_0:refreshMulti()
end

function var_0_0._btnclosemultOnClick(arg_16_0)
	arg_16_0._isMultiOpen = false

	arg_16_0:refreshMulti()
end

return var_0_0
