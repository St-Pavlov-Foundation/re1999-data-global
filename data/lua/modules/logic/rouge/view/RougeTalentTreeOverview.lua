module("modules.logic.rouge.view.RougeTalentTreeOverview", package.seeall)

local var_0_0 = class("RougeTalentTreeOverview", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/Content/base/#go_attribute/attribute")
	arg_1_0._gotalentitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem")
	arg_1_0._godetails = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem/#go_details")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._attributeItemList = {}
	arg_1_0._talentItemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._talentItemList) do
		if iter_3_1 and iter_3_1.btn then
			iter_3_1.btn:RemoveClickListener()
		end
	end
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._season = RougeOutsideModel.instance:season()

	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentOverView)

	arg_6_0._attributeMo, arg_6_0._showMo = RougeTalentModel.instance:calculateTalent()

	if not arg_6_0._showMo and not arg_6_0._attributeMo then
		gohelper.setActive(arg_6_0._goempty, true)
		gohelper.setActive(arg_6_0._scrolldesc.gameObject, false)

		return
	else
		gohelper.setActive(arg_6_0._goempty, false)
		gohelper.setActive(arg_6_0._scrolldesc.gameObject, true)
	end

	if next(arg_6_0._showMo) then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._showMo) do
			local var_6_0 = arg_6_0._talentItemList[iter_6_0]

			if not var_6_0 then
				var_6_0 = arg_6_0:getUserDataTb_()

				local var_6_1 = gohelper.cloneInPlace(arg_6_0._gotalentitem, iter_6_0)
				local var_6_2 = gohelper.findChildText(var_6_1, "info/img_titleline/#txt_talenname")
				local var_6_3 = gohelper.findChildImage(var_6_1, "info/img_titleline/#image_icon")
				local var_6_4 = gohelper.findChildButton(var_6_1, "info/#btn_arrow")
				local var_6_5 = gohelper.findChild(var_6_1, "info/#btn_arrow/open")
				local var_6_6 = gohelper.findChild(var_6_1, "info/#btn_arrow/close")

				var_6_0.go = var_6_1
				var_6_0.name = var_6_2
				var_6_0.icon = var_6_3
				var_6_0.btn = var_6_4
				var_6_0.gobtnopen = var_6_5
				var_6_0.gobtnclose = var_6_6
				var_6_0.isopen = false
				var_6_0.details = {}

				for iter_6_2, iter_6_3 in pairs(iter_6_1) do
					local var_6_7 = arg_6_0:getUserDataTb_()
					local var_6_8 = gohelper.clone(arg_6_0._godetails, var_6_1, iter_6_3)

					var_6_7.go = var_6_8

					gohelper.setActive(var_6_8, false)

					var_6_7.gotalentdesc = gohelper.findChild(var_6_8, "#txt_unlockdec")
					var_6_7.txttalentdesc = gohelper.findChildText(var_6_8, "#txt_unlockdec")
					var_6_7.goUnlockdesc = gohelper.findChild(var_6_8, "#txt_talentdec")
					var_6_7.txtUnlockdesc = gohelper.findChildText(var_6_8, "#txt_talentdec")

					local var_6_9 = RougeTalentConfig.instance:getBranchConfigByID(arg_6_0._season, iter_6_3)
					local var_6_10 = var_6_9.isOrigin == 1

					gohelper.setActive(var_6_7.gotalentdesc, not var_6_10)
					gohelper.setActive(var_6_7.goUnlockdesc, var_6_10)

					var_6_7.txttalentdesc.text = var_6_9.desc
					var_6_7.txtUnlockdesc.text = var_6_9.desc
					var_6_0.details[iter_6_3] = var_6_7
				end

				local function var_6_11()
					var_6_0.isopen = not var_6_0.isopen

					if next(var_6_0.details) then
						for iter_7_0, iter_7_1 in pairs(var_6_0.details) do
							local var_7_0 = iter_7_1.go

							gohelper.setActive(var_7_0, var_6_0.isopen)
						end
					end

					gohelper.setActive(var_6_5, var_6_0.isopen)
					gohelper.setActive(var_6_6, not var_6_0.isopen)
					AudioMgr.instance:trigger(AudioEnum.UI.ClickOverBranch)
				end

				gohelper.setActive(var_6_5, false)
				gohelper.setActive(var_6_6, true)
				var_6_0.btn:AddClickListener(var_6_11, arg_6_0)
				gohelper.setActive(var_6_1, true)

				arg_6_0._talentItemList[iter_6_0] = var_6_0
			end

			local var_6_12 = RougeTalentConfig.instance:getConfigByTalent(arg_6_0._season, iter_6_0)

			var_6_0.name.text = var_6_12.name

			UISpriteSetMgr.instance:setRougeSprite(var_6_0.icon, var_6_12.icon)
		end
	end

	if #arg_6_0._attributeMo > 0 then
		for iter_6_4, iter_6_5 in ipairs(arg_6_0._attributeMo) do
			local var_6_13 = arg_6_0._attributeItemList[iter_6_4]

			if not var_6_13 then
				var_6_13 = arg_6_0:getUserDataTb_()

				local var_6_14 = gohelper.cloneInPlace(arg_6_0._goattribute, iter_6_4)
				local var_6_15 = gohelper.findChildImage(var_6_14, "icon")
				local var_6_16 = gohelper.findChildText(var_6_14, "txt_attribute")
				local var_6_17 = gohelper.findChildText(var_6_14, "name")
				local var_6_18 = gohelper.findChild(var_6_14, "bg")

				var_6_13.go = var_6_14
				var_6_13.rate = var_6_16
				var_6_13.name = var_6_17
				var_6_13.icon = var_6_15

				local var_6_19 = math.ceil(iter_6_4 / 2) % 2 ~= 0

				gohelper.setActive(var_6_14, true)
				gohelper.setActive(var_6_18, var_6_19)
				table.insert(arg_6_0._attributeItemList, var_6_13)
			end

			if iter_6_5.ismul then
				local var_6_20 = "+" .. iter_6_5.rate * 0.1 .. "%"
				local var_6_21 = "+" .. iter_6_5.rate .. "%"

				var_6_13.rate.text = iter_6_5.isattribute and var_6_20 or var_6_21
			else
				var_6_13.rate.text = "+" .. iter_6_5.rate
			end

			if iter_6_5.isattribute then
				if iter_6_5.id == 215 or iter_6_5.id == 216 then
					UISpriteSetMgr.instance:setCommonSprite(var_6_13.icon, iter_6_5.icon)
				end

				UISpriteSetMgr.instance:setCommonSprite(var_6_13.icon, iter_6_5.icon)
			else
				UISpriteSetMgr.instance:setRougeSprite(var_6_13.icon, iter_6_5.icon)
			end

			var_6_13.name.text = iter_6_5.name
		end
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
