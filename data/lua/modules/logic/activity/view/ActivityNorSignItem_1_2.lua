module("modules.logic.activity.view.ActivityNorSignItem_1_2", package.seeall)

local var_0_0 = class("ActivityNorSignItem_1_2", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gobg = gohelper.findChild(arg_1_1, "normalbg")
	arg_1_0._todaybg = gohelper.findChild(arg_1_1, "todaybg")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_1, "datecn")
	arg_1_0._txtdateEn = gohelper.findChildText(arg_1_1, "dateen")
	arg_1_0._goreward = gohelper.findChild(arg_1_1, "#go_reward")
	arg_1_0._gotomorrowtag = gohelper.findChild(arg_1_1, "go_tomorrowtag")
	arg_1_0._goget = gohelper.findChild(arg_1_1, "get")
	arg_1_0._gomask = gohelper.findChild(arg_1_1, "mask")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0._gobg)
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "#go_reward/#txt_name")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._anim.enabled = false
	arg_1_0._go = arg_1_1

	gohelper.setActive(arg_1_1, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	local var_4_0 = arg_4_0._mo.data[1]
	local var_4_1 = ActivityType101Model.instance:isType101RewardCouldGet(var_4_0, arg_4_0._index)
	local var_4_2 = ActivityType101Model.instance:getType101LoginCount(var_4_0)

	if var_4_1 then
		Activity101Rpc.instance:sendGet101BonusRequest(var_4_0, arg_4_0._index)
	end

	if var_4_2 < arg_4_0._index then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshItem()
	TaskDispatcher.runDelay(arg_5_0._playAnimation, arg_5_0, arg_5_0._index * 0.03)
end

function var_0_0._refreshItem(arg_6_0)
	local var_6_0 = arg_6_0._mo.data[1]
	local var_6_1 = string.splitToNumber(ActivityConfig.instance:getNorSignActivityCo(var_6_0, arg_6_0._index).bonus, "#")
	local var_6_2, var_6_3 = ItemModel.instance:getItemConfigAndIcon(var_6_1[1], var_6_1[2])

	if not arg_6_0._item then
		arg_6_0._item = IconMgr.instance:getCommonPropItemIcon(arg_6_0._goreward)
	end

	arg_6_0._item:setMOValue(var_6_1[1], var_6_1[2], var_6_1[3], nil, true)
	arg_6_0._item:setScale(0.8)
	arg_6_0._item:showName(arg_6_0._txtname)

	arg_6_0._txtname.text = var_6_2.name

	arg_6_0._item:setNameType("<color=#3A3836><size=38>%s</size></color>")
	arg_6_0._item:setCountFontSize(35)

	arg_6_0._txtdate.text = "0" .. arg_6_0._index
	arg_6_0._txtdateEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(arg_6_0._index))

	local var_6_4 = ActivityType101Model.instance:isType101RewardGet(var_6_0, arg_6_0._index)
	local var_6_5 = ActivityType101Model.instance:isType101RewardCouldGet(var_6_0, arg_6_0._index)
	local var_6_6 = ActivityType101Model.instance:getType101LoginCount(var_6_0)

	gohelper.setActive(arg_6_0._goget, var_6_4)
	gohelper.setActive(arg_6_0._gomask, var_6_4 or var_6_6 < arg_6_0._index)
	gohelper.setActive(arg_6_0._todaybg, var_6_5)
	gohelper.setActive(arg_6_0._gotomorrowtag, arg_6_0._index ~= 7 and arg_6_0._index == var_6_6 + 1)

	if var_6_4 then
		ZProj.UGUIHelper.SetColorAlpha(arg_6_0._gomask:GetComponent("Image"), 0.68)
	else
		ZProj.UGUIHelper.SetColorAlpha(arg_6_0._gomask:GetComponent("Image"), 0)
	end

	if not var_6_4 and var_6_5 then
		arg_6_0._item:customOnClickCallback(arg_6_0._onItemClick, arg_6_0)
	else
		arg_6_0._item:customOnClickCallback(nil)
	end
end

function var_0_0._playAnimation(arg_7_0)
	gohelper.setActive(arg_7_0._go, true)

	arg_7_0._anim.enabled = true
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playAnimation, arg_8_0)
end

return var_0_0
