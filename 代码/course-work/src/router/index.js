import Vue from 'vue'
import Router from 'vue-router'
import login from '@/view/login.vue'
import courseList from '@/view/courseList'
import registerView from '@/view/registerView'
import mainContainer from '@/view/mainContainer'
import indexPage from '@/view/indexPage'
import coursePage from '@/view/coursePage'
import workList from '@/view/workList'
import submitWorkList from '@/view/submitWorkList'
import submitWorkPage from '@/view/submitWorkPage'
import examResult from '@/view/examResult'
import subjectList from '@/view/subjectList'
import subjectDetails from '@/view/subjectDetails'
import test from '@/view/test'
import examView from '@/view/student/examView'
import examContainer from '@/view/examContainer'
import examIndex from '@/view/examIndex.vue'
import userList from '@/view/userList'
import userAdd from '@/view/userAdd'
import questionFillingDetail from '@/view/questionFillingDetail'
import questionList from '@/view/questionList'
import questionMultipleDetail from '@/view/questionMultipleDetail'
import questionShortAnswerDetail from '@/view/questionShortAnswerDetail'
import questionSingleDetail from '@/view/questionSingleDetail'
import questionTrueFalseDetail from '@/view/questionTrueFalseDetail'
import paperList from '@/view/paperList'
import paperDetails from '@/view/paperDetails'
import examList from '@/view/examList'
import examDetails from '@/view/examDetails'
import markPaperList from '@/view/markPaperList'
import joinExam from '@/view/joinExam'
import markExam from '@/view/markExam'
import scoreAnalysis from '@/view/scoreAnalysis'
import logList from '@/view/logList'
import statistics from '@/view/statistics'

Vue.use(Router)
export default new Router({
  routes: [{
    path: '/test',
    name: 'test',
    component: test
  },
  {
    path: '/',
    redirect: '/login_page',
  },
  {
    path: '/login_page',
    name: 'login_page',
    component: login
  },
  {
    path: '/register_view',
    name: 'register_view',
    component: registerView,
  },
  {
    path: '/main_container',
    name: 'main_container',
    redirect: '/main_container/index_page',
    component: mainContainer,
    children: [
      {
        path: 'course_list',
        component: courseList,
        name: 'course_list'
      },
      {
        path: 'index_page',
        component: indexPage,
        name: 'index_page'
      },
      {
        path: 'boutique',
        component: indexPage,
        name: 'boutique'
      },
      {
        path: 'my_boutique',
        component: indexPage,
        name: 'my_boutique'
      },
      {
        path: 'prepare_course',
        component: indexPage,
        name: 'prepare_course'
      },
    ]
  },
  {
    path: '/course_page',
    component: coursePage,
    name: 'course_page',
    children: [
      {
        path: 'course_index_page',
        ocmponent: indexPage,
        name: 'course_index_page'
      },
      {
        path: 'course_interaction',
        component: indexPage,
        name: 'course_interaction'
      },
      {
        path: 'course_work',
        component: workList,
        name: 'course_work'
      },
      {
        path: 'course_topic',
        component: indexPage,
        name: 'course_topic'
      },
      {
        path: 'course_data',
        component: indexPage,
        name: 'course_data'
      },
      {
        path: 'course_test',
        component: indexPage,
        name: 'course_test'
      },
      {
        path: 'course_notice',
        component: indexPage,
        name: 'course_notice'
      },
    ]
  },

  {
    path: "/submit_work_list",
    component: submitWorkList,
    name: "submit_work_list"
  },
  {
    path: '/submit_work_page',
    component: submitWorkPage,
    name: 'submit_work_page'
  },
  {
    path: "/exam_view",
    component: examView,
    name: 'exam_view'
  },
  {
    path: "/exam_result",
    component: examResult,
    name: 'exam_result'
  }, {
    path: '/exam_container',
    component: examContainer,
    name: 'exam_container',
    redirect: '/exam_container/exam_index',
    children: [
      {
        path: 'exam_index',
        component: examIndex,
        name: 'exam_index'
      }, {
        path: 'subject_list',
        component: subjectList,
        name: 'subject_list'
      }, {
        path: 'subject_details',
        component: subjectDetails,
        name: 'subject_details'
      }, {
        path: 'user_list',
        component: userList,
        name: 'user_list'
      }, {
        path: 'user_add',
        component: userAdd,
        name: 'user_add',
        redirect: 'user_add/register_view',
        children: [{
          path: 'register_view',
          component: registerView,
          name: 'admin_add_register_view'
        }
        ]
      },
      {
        path: 'question_list',
        component: questionList,
        name: 'question_list'
      }, {
        path: 'question_single_choice_edit',
        component: questionSingleDetail,
        name: 'question_single_choice_edit'
      }, {
        path: 'question_multiple_choice_edit',
        component: questionMultipleDetail,
        name: 'question_multiple_choice_edit'
      }, {
        path: 'quesiton_true_false_edit',
        component: questionTrueFalseDetail,
        name: 'quesiton_true_false_edit'
      }, {
        path: 'quesiton_filling_edit',
        component: questionFillingDetail,
        name: 'quesiton_filling_edit'
      }, {
        path: 'questin_short_answer_edit',
        component: questionShortAnswerDetail,
        name: 'questin_short_answer_edit'
      },
      {
        path: 'paper_list',
        component: paperList,
        name: 'paper_list'
      },
      
      {
        path: 'paper_details',
        component: paperDetails,
        name: 'paper_details'
      },
      {
        path: 'exam_list',
        component: examList,
        name: 'exam_list'
      },
      {
        path: 'exam_details',
        component: examDetails,
        name: 'exam_details'
      },
      {
        path: 'mark_paper_list',
        component: markPaperList,
        name: 'mark_paper_list'
      },
      {
        path: 'join_exam',
        component: joinExam,
        name: 'join_exam'
      },
      {
        path: 'mark_exam',
        component: markExam,
        name: 'mark_exam'
      },
      {
        path: 'score_analysis',
        component: scoreAnalysis,
        name: 'score_analysis'
      },
      {
        path: 'log_list',
        component: logList,
        name: 'log_list'
      },
      {
        path: 'statistics',
        component: statistics,
        name: 'statistics'
      },
    ]
  }
  ]
})
