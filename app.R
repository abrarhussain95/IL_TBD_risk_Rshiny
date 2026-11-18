library(shiny)
library(htmltools)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .container-fluid { width: 100%; max-width: 1600px; }
      iframe { background-color: white; }
      .app-header { display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; margin:10px 0 14px; }
      .app-header h2 { margin:0; font-weight:bold; }
      .app-header img { height:46px; margin-left:12px; }
      .map-note { margin:10px 0 6px; color:#444; }
      .about-page { max-width:none; margin-top:16px; font-size:15px; line-height:1.55; }
      .about-page details { border:1px solid #ddd; border-radius:6px; margin-bottom:10px; }
      .about-page summary { cursor:pointer; padding:12px 16px; font-size:17px; font-weight:600; color:#13294B; }
      .about-page .body { padding:4px 18px 14px; }
      .about-page table td, .about-page table th { border:1px solid #ddd; padding:6px 10px; }
      .tick-card { border:1px solid #eee; border-radius:6px; padding:12px; margin-bottom:10px; }
      .tick-card img { display:block; width:100%; height:180px; object-fit:contain; background:#fff; margin:0 0 8px; }
    "))
  ),
  
  div(class = "app-header",
      h2("Monthly tick-borne disease risk in Illinois"),
      tags$a(href = "https://vetmed.illinois.edu/mdci/", target = "_blank",
             img(src = "logo_mdci.png", alt = "Modeling for Disease Control Improvement"))),
  
  tabsetPanel(
    
    # ---------------- About tab ----------------
    tabPanel("About",
             div(class = "about-page",
                 
                 tags$details(open = NA, tags$summary("About this map"), div(class = "body", HTML(r"[
          <p>This app shows how the <b>relative risk of tick-borne disease</b> changes across all 102 Illinois
          counties, month by month, for three ticks: the <b>Lone Star tick</b> (<i>Amblyomma americanum</i>),
          the <b>American dog tick</b> (<i>Dermacentor variabilis</i>), and the <b>blacklegged (deer) tick</b>
          (<i>Ixodes scapularis</i>).</p>
          <p><b>Who it is for:</b> Illinois residents who want to know when and where to take extra care against
          tick bites, and public health professionals planning surveillance, prevention messages, and outreach.</p>
          <p><b>Why we built it:</b> Each tick lives in different places, is active at different times of year,
          and carries different diseases. Maps of where ticks have been found don't show how risk changes month
          to month. This map brings tick abundance, pathogen testing, and seasonal tick activity together so
          people can see <b>where and when</b> risk is highest.</p>
          <p><b>How to use it:</b> Choose a tick tab, choose a month at the top right of the map, and click a
          county to see its value and category.</p>
        ]"))),
        
        tags$details(tags$summary("How to read the maps"), div(class = "body", HTML(r"[
          <table>
            <tr><th>Category</th><th>Score</th></tr>
            <tr><td>Very low</td><td>0.00 to 0.01</td></tr>
            <tr><td>Low</td><td>0.01 to 0.10</td></tr>
            <tr><td>Medium</td><td>0.10 to 0.30</td></tr>
            <tr><td>High</td><td>0.30 to 0.60</td></tr>
            <tr><td>Very high</td><td>above 0.60</td></tr>
          </table>
          <ul>
            <li><b>Scores are relative.</b> They compare counties and months for the same tick, not your personal chance of getting sick.</li>
            <li><b>Don't compare scores between ticks.</b> Each tick is scaled separately.</li>
            <li><b>Scores are smoothed.</b> Each county's value is the average of the counties that border it.</li>
            <li><b>"Very low" is not "no risk."</b> Ticks are found across Illinois.</li>
          </ul>
        ]"))),
        
        tags$details(tags$summary("Know your ticks"), div(class = "body",
                                                          HTML("<p><i>Diseases listed have been reported in Illinois.</i></p>"),
                                                          fluidRow(
                                                            column(4, div(class = "tick-card", HTML(r"[
            <img src="lone_star_tick.png" alt="Lone Star tick"><h4>Lone Star tick</h4>
            <p><b>Look:</b> Adult female has one white dot on her back.<br>
            <b>Active:</b> Mainly spring and summer.<br>
            <b>Hosts:</b> Deer are key hosts.<br>
            <b>Diseases in humans:</b> Ehrlichiosis, Heartland virus, tularemia, and alpha-gal syndrome (red meat allergy).<br>
            <b>Diseases in animals:</b> Ehrlichiosis in dogs. Cytauxzoonosis (life-threatening) in cats.</p>
          ]"))),
          column(4, div(class = "tick-card", HTML(r"[
            <img src="american_dog_tick.png" alt="American dog tick"><h4>American dog tick</h4>
            <p><b>Look:</b> Brown with whitish-gray markings.<br>
            <b>Active:</b> Spring and summer.<br>
            <b>Hosts:</b> Small rodents, dogs, and other mammals.<br>
            <b>Diseases in humans:</b> Rocky Mountain spotted fever and tularemia.<br>
            <b>Diseases in animals:</b> Rocky Mountain spotted fever and tularemia in dogs.</p>
          ]"))),
          column(4, div(class = "tick-card", HTML(r"[
            <img src="blacklegged_tick.png" alt="Blacklegged tick"><h4>Blacklegged (deer) tick</h4>
            <p><b>Look:</b> Reddish-orange body, dark shield, and black legs. Nymphs are tiny.<br>
            <b>Active:</b> Spring, summer, and fall, plus winter days above freezing.<br>
            <b>Hosts:</b> Deer are the main hosts for adult ticks.<br>
            <b>Diseases in humans:</b> Lyme disease, anaplasmosis, babesiosis, and Powassan virus (first Illinois case in 2025).<br>
            <b>Diseases in animals:</b> Lyme disease and anaplasmosis in dogs.</p>
          ]")))
                                                          ))),
        
        tags$details(tags$summary("Prevention and what to do after a bite"), div(class = "body", HTML(r"[
          <ul>
            <li>Use an EPA-registered insect repellent.</li>
            <li>Treat clothing with 0.5% permethrin.</li>
            <li>After being outdoors, check your whole body, children, and pets, and shower soon.</li>
            <li>Remove an attached tick with fine-tipped tweezers close to the skin. Pull upward with steady pressure, then clean the area. Removing it within 24 hours lowers the risk.</li>
            <li>Watch for 30 days. See a provider for rash, fever, tiredness, headache, or muscle or joint pain, and mention the bite.</li>
            <li>Ask your vet about tick prevention. Some dog products are not safe for cats.</li>
          </ul>
          <p><a href="https://www.cdc.gov/ticks/prevention/index.html" target="_blank">CDC: Preventing tick bites</a> ·
          <a href="https://www.cdc.gov/ticks/after-a-tick-bite/" target="_blank">CDC: After a tick bite</a> ·
          <a href="https://dph.illinois.gov/topics-services/diseases-and-conditions/tickborne-illnesses.html" target="_blank">IDPH: Tickborne illnesses</a></p>
        ]"))),
        
        tags$details(tags$summary("Data"), div(class = "body", HTML(r"[
          <ul>
            <li>Predicted tick abundance (Bayesian spatial models using climate, landcover, host and sampled tick data)</li>
            <li>Pathogen prevalence (IDPH)</li>
            <li>Tick bite reports (I-Tick app)</li>
            <li>Human cases (IDPH)</li>
            <li>Seasonal activity (from human cases, tick bites, and tick sampling)</li>
          </ul>
          <p><i>Note: All data cover the period 2019–2022.</i></p>
        ]"))),
        
        tags$details(tags$summary("Citation, contact, and credits"), div(class = "body", HTML(r"[
          <p><b>Cite this work</b></p>
          <ol>
            <li>Hussain A, Bravo de Guenni L, Mateus-Pinilla N, Smith RL. <i>Bayesian spatial prediction of three
            medically important tick species in Illinois.</i> Preprint, 2026.
            <a href="https://doi.org/10.64898/2026.04.16.719082" target="_blank">Read the paper</a></li>
            <li>Hussain A, Bhowmick S, Mateus-Pinilla N, Smith RL. <i>Mapping county-level tick-borne disease risk in
            Illinois by integrating vector abundance, pathogen prevalence, and phenology.</i> Preprint, 2026.
            <a href="https://www.medrxiv.org/content/10.64898/2026.10.14.26365569v1" target="_blank">Read the paper</a></li>
          </ol>
          <p><b>Contact:</b> Abrar Hussain, <a href="mailto:abrarh2@illinois.edu">abrarh2@illinois.edu</a> ·
          Rebecca L. Smith, <a href="mailto:rlsdvm@illinois.edu">rlsdvm@illinois.edu</a></p>
          <p><small><b>Tick photos:</b> CDC Public Health Image Library (<a href="https://phil.cdc.gov" target="_blank">phil.cdc.gov</a>).
          Lone Star tick: PHIL #28369, photo by Lauren Bishop.
          American dog tick: PHIL #170, photo by James Gathany (content provider Gary O. Maupin).
          Blacklegged tick: PHIL #1669, photo by Jim Gathany (content provider Michael L. Levin, PhD).</small></p>
          <p>We thank IDPH for providing data. This map is for information only and is not medical or veterinary advice.</p>
        ]")))
             )
    ),
    
    # ---------------- Map tabs ----------------
    tabPanel(
      tags$span(tags$i("Amblyomma americanum"), " (Lone Star Tick)"),
      div(class = "map-note", "Relative monthly risk of ehrlichiosis by county. See the About tab for details."),
      tags$iframe(src = "map_aa_monthly.html", style = "width:100%; height:850px; border:none;")
    ),
    tabPanel(
      tags$span(tags$i("Dermacentor variabilis"), " (American Dog Tick)"),
      div(class = "map-note", "Relative monthly risk of spotted fever rickettsioses by county. See the About tab for details."),
      tags$iframe(src = "map_dv_monthly.html", style = "width:100%; height:850px; border:none;")
    ),
    tabPanel(
      tags$span(tags$i("Ixodes scapularis"), " (Black-legged Tick)"),
      div(class = "map-note", "Relative monthly risk of Lyme disease, anaplasmosis, and babesiosis by county. See the About tab for details."),
      tags$iframe(src = "map_is_monthly.html", style = "width:100%; height:850px; border:none;")
    )
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)