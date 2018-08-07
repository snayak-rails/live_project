class EmployeesDatatable < AjaxDatatablesRails::Base
  extend Forwardable

  def_delegators :@view, :link_to, :edit_employee_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      name: { source: "Employee.first_name", cond: :like },
      role: { source: "Employee.role", cond: :like },
      grade: { source: "Employee.grade", cond: :like },
      location: { source: 'Employee.location', cond: :like },
      profile: { source: 'Employee.profile', cond: :like },
      engagement: { source: 'Employee.engagement', cond: :like },
      projects: { source: "Project.name", cond: :like },
      skills: { source: "Skill.name", cond: :like },
      lead: { source: "Employee.first_name", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        name: record.full_name,
        role: record.role&.titleize,
        grade: record.grade,
        location: record.location,
        profile: record.profile&.titleize,
        engagement: record.engagement&.titleize,
        projects: record.current_project_names,
        skills: record.skill_names,
        lead: record.lead&.full_name,
        edit: link_to("<i class='fa fa-pencil-square-o' aria-hidden='true'></i>".html_safe, edit_employee_path(record)),
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Employee.left_outer_joins(:projects, :skills, :lead).distinct
  end

end
