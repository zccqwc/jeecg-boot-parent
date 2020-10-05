<template>
  <a-card :bordered="false">
    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="48">

          <a-col :md="8" :sm="24">
            <a-form-item label="园区" >
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0" >
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :md="8" :sm="24">
            <a-form-item label="楼栋">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="单元">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="楼层">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="宿舍号">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="电表类型">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="开关状态">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="行数">
              <a-select v-model="queryParam.status" placeholder="请选择" default-value="0">
                <a-select-option value="0" v-for="area in areaList">{{area}}</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :md="!advanced && 8 || 24" :sm="24">
            <span class="table-page-search-submitButtons" :style="advanced && { float: 'right', overflow: 'hidden' } || {} ">
              <a-button type="primary">查询</a-button>
              <a-button style="margin-left: 8px" @click="resetSearchForm">重置</a-button>
              <a @click="toggleAdvanced" style="margin-left: 8px">
                {{ advanced ? '收起' : '展开' }}
                <a-icon :type="advanced ? 'up' : 'down'"/>
              </a>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="() => this.handleModalVisible(true)">新建</a-button>
      <a-dropdown v-if="selectedRowKeys.length > 0">
        <a-menu slot="overlay">
          <a-menu-item key="1"><a-icon type="Unlock" />批量解锁</a-menu-item>
          <!-- lock | unlock -->
          <a-menu-item key="2"><a-icon type="lock" />批量锁定</a-menu-item>
        </a-menu>
        <a-button style="margin-left: 8px">
          批量操作 <a-icon type="down" />
        </a-button>
      </a-dropdown>
    </div>

    <s-table
      ref="table"
      size="default"
      :columns="columns"
      :data="loadData"
      :showAlertInfo="true"
      @onSelect="onChange"
    >
    </s-table>



    <a-modal title="新建规则" destroyOnClose :visible="visibleCreateModal" @ok="handleCreateModalOk" @cancel="handleCreateModalCancel">
      <!---->
      <a-form style="margin-top: 8px" :autoFormCreate="(form)=>{this.createForm = form}">
        <a-form-item :labelCol="{ span: 5 }" :wrapperCol="{ span: 15 }" label="描述" fieldDecoratorId="description" :fieldDecoratorOptions="{rules: [{ required: true, message: '请输入至少五个字符的规则描述！', min: 5 }]}">
          <a-input placeholder="请输入" />
        </a-form-item>
      </a-form>
    </a-modal>

  </a-card>
</template>

<script>
import STable from '@/components/table/'
import ATextarea from "ant-design-vue/es/input/TextArea"
import AInput from "ant-design-vue/es/input/Input"
import moment from "moment"
import axios from 'axios'
import { getRoleList, getServiceList, getAction} from '@/api/manage'


export default {
  name: "TableList",
  components: {
    AInput,
    ATextarea,
    STable
  },
  data () {
    return {
      visibleCreateModal:false,
      visible: false,
      labelCol: {
        xs: { span: 24 },
        sm: { span: 5 },
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 12 },
      },
      form: null,
      mdl: {},

      // 高级搜索 展开/关闭
      advanced: true,
      // 查询参数
      queryParam: {},
      // 表头
      columns: [
        {
          title: '园区',
          dataIndex: 'area_name'
        },
        {
          title: '楼栋',
          dataIndex: 'building_name'
        },

        {
          title: '宿舍号',
          dataIndex: 'dormitory_name',
          needTotal: true
        },
        {
          title: '照明',
          dataIndex: 'elec_type'
        },
        {
          title: '更新时间',
          dataIndex: 'updatedAt',

        },
        {
          title: '资费状态',
          dataIndex: 'postage_status',

        },
        {
          title: '账户余额',
          dataIndex: 'Account_balance'
        },
        {
          title: '剩余补贴',
          dataIndex: 'Surplus_subsidy'
        },
        {
          title: '宿舍人数',
          dataIndex: 'num_people'
        },
        {
          title: '用电状态',
          dataIndex: 'power_status'
        },{
          title: '开关操作',
          dataIndex: 'switch_state'
        }

      ],
      // 加载数据方法 必须为 Promise 对象
      loadData: parameter => {
        return getServiceList(Object.assign(parameter, this.queryParam))
          .then(res => {
            return res.result
          })
      },

      selectedRowKeys: [],
      selectedRows: [],
      areaList: [],

      }
  },
  created () {
    getRoleList({ t: new Date()});
    this.queryArea()
  },


  methods: {
    handleEdit (record) {
      this.mdl = Object.assign({}, record)
      console.log(this.mdl)
      this.visible = true
    },
    handleOk () {

    },

    //添加逻辑
    handleModalVisible(isVisible) {
      this.visibleCreateModal = isVisible;
    },
    handleCreateModalOk() {
      this.createForm.validateFields((err, fieldsValue) => {
        if (err) {
          return;
        }
        const description = this.createForm.getFieldValue('description');
        axios.post('/saveRule', {
          desc: description,
        }).then((res) => {
          this.createForm.resetFields();
          this.visibleCreateModal = false;
          this.loadRuleData();
        });
      });
    },
    handleCreateModalCancel() {
      this.visibleCreateModal = false;
    },

    onChange (row) {
      this.selectedRowKeys = row.selectedRowKeys
      this.selectedRows = row.selectedRows

      console.log(this.$refs.table)
    },
    toggleAdvanced () {
      this.advanced = !this.advanced
    },

    resetSearchForm () {
      this.queryParam = {
        date: moment(new Date())
      }
    },
    queryArea () {
      var url = "/test/jeecgDemo/hello"
      getAction(url).then((res) => {
        if (res.success) {
          this.areaList = res.result;
        }
      })
    }
  },

  watch: {
    /*
    'selectedRows': function (selectedRows) {
      this.needTotalList = this.needTotalList.map(item => {
        return {
          ...item,
          total: selectedRows.reduce( (sum, val) => {
            return sum + val[item.dataIndex]
          }, 0)
        }
      })
    }
    */
  },

}
</script>