module("modules.logic.summon.view.luckybag.SummonGetLuckyBagView", package.seeall)

local var_0_0 = class("SummonGetLuckyBagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._gocollection = gohelper.findChild(arg_1_0.viewGO, "content/#go_collection")

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
	arg_4_0._bgClick = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0._bgClick:AddClickListener(arg_4_0._onClickBG, arg_4_0)
	gohelper.setActive(arg_4_0._gocollection, false)

	arg_4_0._simageIconList = arg_4_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._bgClick:RemoveClickListener()
end

function var_0_0.onOpen(arg_6_0)
	logNormal("SummonGetLuckyBagView onOpen")
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_gain)
	arg_6_0:refreshView()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0.poolId = arg_8_0.viewParam.poolId

	local var_8_0 = arg_8_0.viewParam.luckyBagIdList

	if #var_8_0 <= 0 then
		logError("抽卡 福袋 id列表为空")

		return
	end

	gohelper.CreateObjList(arg_8_0, arg_8_0.onShowItem, var_8_0, nil, arg_8_0._gocollection)
end

function var_0_0.onShowItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = SummonConfig.instance:getLuckyBag(arg_9_0.poolId, arg_9_2)

	if var_9_0 then
		local var_9_1 = gohelper.findChildTextMesh(arg_9_1, "txt_name")
		local var_9_2 = gohelper.findChildTextMesh(arg_9_1, "en")
		local var_9_3 = gohelper.findChildSingleImage(arg_9_1, "#simage_icon")

		var_9_1.text = var_9_0.name
		var_9_2.text = var_9_0.nameEn or ""

		table.insert(arg_9_0._simageIconList, var_9_3)
		var_9_3:LoadImage(ResUrl.getSummonCoverBg(var_9_0.icon))
	end
end

function var_0_0._onClickBG(arg_10_0)
	arg_10_0:closeThis()

	if arg_10_0._simageIconList and next(arg_10_0._simageIconList) then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._simageIconList) do
			iter_10_1:UnLoadImage()
		end

		tabletool.clear(arg_10_0._simageIconList)

		arg_10_0._simageIconList = nil
	end
end

return var_0_0
