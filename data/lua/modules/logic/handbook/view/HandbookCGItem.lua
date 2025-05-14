module("modules.logic.handbook.view.HandbookCGItem", package.seeall)

local var_0_0 = class("HandbookCGItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_time")
	arg_1_0._txtmessycodetime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_messycodetime")
	arg_1_0._txttitleName = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_titleName")
	arg_1_0._txttitleNameEN = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_titleNameEN")
	arg_1_0._gocg = gohelper.findChild(arg_1_0.viewGO, "#go_cg")

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
	arg_4_0:addEventCb(HandbookController.instance, HandbookEvent.OnReadInfoChanged, arg_4_0._onReadInfoChanged, arg_4_0)

	arg_4_0._cgItemList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.go = gohelper.findChild(arg_4_0._gocg, "go_cg" .. iter_4_0)
		var_4_0.simagecgicon = gohelper.findChildSingleImage(var_4_0.go, "mask/simage_cgicon")
		var_4_0.gonew = gohelper.findChild(var_4_0.go, "go_new")
		var_4_0.btnclick = gohelper.findChildButtonWithAudio(var_4_0.go, "btn_click", AudioEnum.UI.play_ui_screenplay_photo_open)

		var_4_0.btnclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0, iter_4_0)
		table.insert(arg_4_0._cgItemList, var_4_0)
	end
end

function var_0_0._btnclickOnClick(arg_5_0, arg_5_1)
	if arg_5_0._mo.isTitle then
		return
	end

	local var_5_0 = arg_5_0._mo.cgList[arg_5_1]

	if not var_5_0 then
		return
	end

	HandbookController.instance:openCGDetailView({
		id = var_5_0.id,
		cgType = arg_5_0._cgType
	})

	local var_5_1 = arg_5_0._cgItemList[arg_5_1]

	gohelper.setActive(var_5_1.gonew, false)
end

function var_0_0._refreshUI(arg_6_0)
	gohelper.setActive(arg_6_0._gotitle, arg_6_0._mo.isTitle)
	gohelper.setActive(arg_6_0._gocg, not arg_6_0._mo.isTitle)

	if arg_6_0._mo.isTitle then
		local var_6_0 = arg_6_0._mo.storyChapterId
		local var_6_1 = HandbookConfig.instance:getStoryChapterConfig(var_6_0)

		arg_6_0._txttitleName.text = var_6_1.name
		arg_6_0._txttitleNameEN.text = var_6_1.nameEn

		local var_6_2 = GameUtil.utf8isnum(var_6_1.year)

		gohelper.setActive(arg_6_0._txttime.gameObject, var_6_2)
		gohelper.setActive(arg_6_0._txtmessycodetime.gameObject, not var_6_2)

		arg_6_0._txttime.text = var_6_2 and var_6_1.year or ""
		arg_6_0._txtmessycodetime.text = var_6_2 and "" or var_6_1.year
	else
		local var_6_3 = arg_6_0._mo.cgList

		for iter_6_0, iter_6_1 in ipairs(var_6_3) do
			local var_6_4 = arg_6_0._cgItemList[iter_6_0]

			var_6_4.simagecgicon:LoadImage(ResUrl.getStorySmallBg(iter_6_1.image))

			local var_6_5 = HandbookModel.instance:isRead(HandbookEnum.Type.CG, iter_6_1.id)

			gohelper.setActive(var_6_4.gonew, not var_6_5)
			gohelper.setActive(var_6_4.go, true)
		end

		for iter_6_2 = #var_6_3 + 1, 3 do
			local var_6_6 = arg_6_0._cgItemList[iter_6_2]

			gohelper.setActive(var_6_6.go, false)
		end
	end
end

function var_0_0._onReadInfoChanged(arg_7_0, arg_7_1)
	if arg_7_0._mo.isTitle then
		return
	end

	local var_7_0 = arg_7_0._mo.cgList

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.id == arg_7_1.id and arg_7_1.type == HandbookEnum.Type.CG then
			local var_7_1 = arg_7_0._cgItemList[iter_7_0]

			gohelper.setActive(var_7_1.gonew, not arg_7_1.isRead)
		end
	end
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._cgType = arg_8_1.cgType

	arg_8_0:_refreshUI()
end

function var_0_0.onDestroy(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._cgItemList) do
		iter_9_1.simagecgicon:UnLoadImage()
		iter_9_1.btnclick:RemoveClickListener()
	end
end

return var_0_0
